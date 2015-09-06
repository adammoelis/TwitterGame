class UsersController < ApplicationController
  # include Key
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"], except: [:index, :show, :update]


  def remove
    if User.where("name Like ?", params[:name]).first
      @user = User.where("name Like ?", params[:name]).first
      @user.remove_from_default
    end
    redirect_to :controller => 'home', :action => 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name)
    end
end
