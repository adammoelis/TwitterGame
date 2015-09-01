class HomeController < ApplicationController
  protect_from_forgery with: :null_session
  http_basic_authenticate_with name: "dhhh", password: "secret", except: [:index, :show]

  def index
    @users = User.all
    @score ||= 0
    @score = params[:score].to_i if params[:score]
    @attempts = params[:attempts].to_i if params[:attempts]
    @attempts ||= 0
    # @score = session[:tmp_score] if session[:tmp_score]
    # @attempts = session[:tmp_attempts] if session[:tmp_attempts]
    render 'home/index'
  end

  def new
    @username = params[:username]
    begin
      @name = Tweet.get_name(@username)
    rescue
    else
      if User.find_by_name(@name)
      else
        Tweet.fetch_tweets_for(@username)
      end
    end
    redirect_to '/home/index'
  end

  # def update
  #   binding.pry
  #   if params[:name] == @user.name
  #     @score = params[:score].to_i + 1
  #   else
  #     @score = params[:score].to_i
  #   end
  #   @attempts = params[:attempts].to_i + 1
  #   @users = User.all
  #   # session[:tmp_score] = @score
  #   # session[:tmp_attempts] = @attempts
  #   redirect_to :controller => 'home', :action => 'index', :score => @score, :attempts => @attempts
  # end


  private

  def user_params
    params.require(:home).permit(:username)
  end


end
