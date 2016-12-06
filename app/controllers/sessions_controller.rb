class SessionsController < ApplicationController
  def create
    #render text: request.env['omniauth.auth'].to_yaml and return
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
    rescue
     flash[:warning] = "There was an error while trying to authenticate you..."
    end
    redirect_to root_path
  end

  def destroy
    if current_user
      session.delete(:user_id)
    end
    redirect_to root_path
  end

  def auth_failure
    redirect_to root_path
  end
end