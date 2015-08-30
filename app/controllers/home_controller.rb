class HomeController < ApplicationController
  protect_from_forgery with: :null_session
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    # binding.pry
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
      # binding.pry

    else
      binding.pry
      if User.find_by_name(@name)
      else
        Tweet.fetch_tweets_for(@username)
      end
      # binding.pry

    end
    redirect_to '/home/index'

  end

  def destroy

  end

  private

  def user_params
    params.require(:home).permit(:username)
  end


end
