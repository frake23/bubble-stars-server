class UsersController < ApplicationController
  before_action :set_user, only: %i[update]

  # GET /users/1
  def show
    return session[:init] = 'init' unless set_user
    render(json: User.where(id: @user.id).select('id, username').first)
  end

  # POST /users
  def create
    user = User.new(user_params)

    if user.save
      log_in user
      render json: { success: true }
    else
      render json: { errors: user.errors }, status: 400
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: 401
    end
  end

  private

  def user_params
    params.permit(:email, :username, :password)
  end
end
