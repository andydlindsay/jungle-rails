class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:anything][:email])
    if user && user.authenticate(params[:anything][:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

end

