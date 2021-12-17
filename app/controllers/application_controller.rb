class ApplicationController < ActionController::API
  private

  def set_user
    @user ||= session[:current_user_id] && User.find_by_id(session[:current_user_id])
  end

  def require_login
    return if logged_in?

    head(401)
  end

  def log_in(user)
    session[:current_user_id] = user.id
  end

  def logged_in?
    !!session[:current_user_id]
  end

  def log_out
    session[:current_user_id] = nil
  end

end
