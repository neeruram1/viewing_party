class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
    redirect_to(root_path) if current_user.nil?
  end

  def require_user
    render file: '/public/401' unless current_user
  end
end
