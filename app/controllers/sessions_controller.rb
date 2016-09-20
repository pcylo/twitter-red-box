class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth(auth_hash)
    session[:user_id] = @user.id
    flash[:success] = "Welcome, #{@user.name}!"
    redirect_to root_path
  end

  def destroy
    if current_user
      session[:user_id] = nil
      flash[:success] = 'Successfuly signed out, bye!'
    end
    redirect_to root_path
  end

  def auth_failure
    flash[:warning] = "We were unable to authenticate your Twitter account, sorry."
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
