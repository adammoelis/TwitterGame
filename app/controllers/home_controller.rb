class HomeController < ApplicationController
  protect_from_forgery with: :null_session
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @users = User.all
    binding.pry
    @score ||= 0
    @score = params[:score] if params[:score]
    @attempts ||= 0
    render 'home/index'
  end

  # def create
  #   @username = params[:username]
  #   # binding.pry
  #
  # end

  def new
    binding.pry
    @username = params[:username]
    begin
      @name = Tweet.get_name(@username)
    rescue
      # binding.pry
      redirect_to 'home/index'
    else
      binding.pry
      if User.find_by_name(@name)
      else
        Tweet.fetch_tweets_for(@username)
      end
      # binding.pry
      redirect_to '/home/index'
    end

  end

  # def update
  #   if params[:name] == @user.name
  #     @score = params[:score].to_i + 1
  #   else
  #     @score = params[:score].to_i
  #   end
  #   @attempts = params[:attempts].to_i + 1
  #   @users = User.all
  #   render "home/index"
  # end

  private

  def user_params
    params.require(:home).permit(:username)
  end


end
