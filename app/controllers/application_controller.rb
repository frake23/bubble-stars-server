class ApplicationController < ActionController::API
  wrap_parameters format: []
  private

  def set_user
    @user ||= session[:current_user_id] && User.find_by_id(session[:current_user_id])

    head(401) unless @user
    @user
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
