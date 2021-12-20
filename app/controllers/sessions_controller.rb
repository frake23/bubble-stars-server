class SessionsController < ApplicationController
  def create
    user = User.find_by_login(params[:login])
    if user&.authenticate(params[:password])
      log_in user
      render json: { success: true }
    else
      render json: { errors: { login: ['Неверный логин или пароль'], password: ['Неверный логин или пароль'] } },
             status: 400
    end
  end

  def destroy
    log_out
    p session
    render json: { success: true }
  end
end
