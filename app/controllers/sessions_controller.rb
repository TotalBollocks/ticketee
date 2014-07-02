class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.where(name: params[:signin][:name]).take
    
    if user && user.authenticate(params[:signin][:password])
      flash[:notice] = "You have signed in"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:notice] = "Invalid name or password"
      render 'new'
    end
  end
end
