class HomeController < ApplicationController
  # include Key
  protect_from_forgery with: :null_session
  # http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"], except: [:index, :show, :update_score, :custom, :add_to_custom]

  def index
    @game = Game.new(0,0)
    @users = User.all
    session[:republican_default] ||= User.find_by(name: "Donald J. Trump").name
    session[:democrat_default] ||= User.find_by(name: "Hillary Clinton").name
    session[:jerseyshore_default] ||= User.find_by(name: "DJ Pauly D").name
    render 'home/index'
  end

  def custom
    @game = Game.new(0,0)
    @users = User.all
    render 'home/custom'

  end


  def new
    @username = params[:username]
    begin
      @name = Tweet.get_name(@username)
    rescue
    else
      if User.find_by_name(@name)
        @user = User.find_by_name(@name)
        @user.add_to_default_game
      else
        @user = Tweet.fetch_tweets_for(@username)
        @user.add_to_default_game
      end
    end
    redirect_to '/'
  end

  def update_score
    @former_right_user = User.find_by(name: params[:user_name])
    if params[:name] == @former_right_user.name
      @answer_status = true
      @score = params[:score].to_i + 1
    else
      @answer_status = false
      @score = params[:score].to_i
    end
    @game = Game.new(@score, params[:attempts].to_i + 1)
    @game.right_person = @former_right_user
    @game.answer_status = @answer_status
    render 'home/index'
  end

  def update_custom_score
    @former_right_user = User.find_by(name: params[:user_name])
    if params[:name] == @former_right_user.name
      @answer_status = true
      @score = params[:score].to_i + 1
    else
      @answer_status = false
      @score = params[:score].to_i
    end
    @game = Game.new(@score, params[:attempts].to_i + 1)
    @game.right_person = @former_right_user
    @game.answer_status = @answer_status
    @users = User.all
    render '/home/custom'
  end

  def set_default
    @user = User.find_by(name: params[:user][:name])
    if @user.republican
      session[:republican_default] = @user.name
    elsif @user.democrat
      session[:democrat_default] = @user.name
    elsif @user.jerseyshore
      session[:jerseyshore_default] = @user.name
    end
    redirect_to '/'
  end

  def add_to_custom
    @username = params[:username]
    begin
      @name = Tweet.get_name(@username, current_account.twitter)
    rescue
      flash[:notice] = "Sorry, we could not locate that username"
    else
      if User.find_by_name(@name)
        @user = User.find_by_name(@name)
        current_account.add_user(@user)
      else
        if current_account.provider == "twitter"
          @user = Tweet.fetch_tweets_for(@username, current_account.twitter)
          if @user.class.name=="User"
            current_account.add_user(@user)
          else
            flash[:notice] = "Sorry, that username has no tweets"
          end
        else
          @user = Tweet.fetch_tweets_for(@username)
          if @user.class.name=="User"
            current_account.add_user(@user)
          else
            flash[:notice] = "Sorry, that username has no tweets"
          end
        end
      end
    end
    redirect_to '/game'
  end

  def remove_from_custom
    if User.where("name Like ?", params[:user][:name]).first
      @user = User.where("name Like ?", params[:user][:name]).first
      current_account.remove_user(@user)
    end
    redirect_to '/game'
  end


  private

  def user_params
    params.require(:home).permit(:username)
  end


end
