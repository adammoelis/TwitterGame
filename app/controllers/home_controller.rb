class HomeController < ApplicationController
  # include Key
  protect_from_forgery with: :null_session
  http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"], except: [:index, :show, :update_score]

  def index
    @game = Game.new(0,0)
    @users = User.all
    render 'home/index'
  end

  def new
    @username = params[:username]
    binding.pry
    begin
      @name = Tweet.get_name(@username)
    rescue
    else
      if User.find_by_name(@name)
        binding.pry
        @user = User.find_by_name(@name)
        @user.add_to_default_game
      else
        binding.pry
        @user = Tweet.fetch_tweets_for(@username)
        @user.add_to_default_game
      end
    end
    redirect_to '/home/index'
  end

  def update_score
    @former_right_user = User.find(params[:user_id])
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
    render 'home/index'
  end

  def update_default


  end


  private

  def user_params
    params.require(:home).permit(:username)
  end


end
