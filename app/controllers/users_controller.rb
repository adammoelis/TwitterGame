class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show, :update]


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if params[:name] == @user.name
      @score = params[:score].to_i + 1
    else
      @score = params[:score].to_i
    end
    @attempts = params[:attempts].to_i + 1
    @users = User.all
    # session[:tmp_score] = @score
    # session[:tmp_attempts] = @attempts
    redirect_to :controller => 'home', :action => 'index', :score => @score, :attempts => @attempts
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    binding.pry

    if User.find_by_name(params[:name])
      @user = User.find_by_name(params[:name])
      @user.destroy
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
