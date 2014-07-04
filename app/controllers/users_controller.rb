class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :delete]
  
  def show
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You have signed up!"
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:notice] = "Profile has been updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
  def find_user
    @user = User.find params[:id]
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
