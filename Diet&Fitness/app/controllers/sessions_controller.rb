class SessionsController < ApplicationController

def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'logged in succesfully'
    else
      flash.now[:alert] = 'Combinación inválida de email/password'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'Logged out'
  end

end
