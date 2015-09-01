class HomeController < ApplicationController
  include Key
  protect_from_forgery with: :null_session
  http_basic_authenticate_with name: USERNAME, password: PASSWORD, except: [:index, :show]

  def index
    @users = User.all
    @score ||= 0
    @score = params[:score].to_i if params[:score]
    @attempts = params[:attempts].to_i if params[:attempts]
    @attempts ||= 0
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

  def update_score
    @former_right_user = User.find(params[:user_id])
    if params[:name] == @former_right_user.name
      @answer_status = true
      @score = params[:score].to_i + 1
    else
      @answer_status = false
      @score = params[:score].to_i
    end
    @attempts = params[:attempts].to_i + 1
    @users = User.all
    render 'home/index'
  end


  private

  def user_params
    params.require(:home).permit(:username)
  end


end
