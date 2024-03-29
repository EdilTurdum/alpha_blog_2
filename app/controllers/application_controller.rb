class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user #double bang returns the boolean of the object.
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You need to be logged in to perform this action."
      redirect_to login_path
    end
  end

end
