class HomeController < ApplicationController
  def index
    @users = User.all
    @user = @users.sample
    render 'home/index'
  end
end
