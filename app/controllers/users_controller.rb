class UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success: (t ".success")
    else
      flash.now[:danger] = (t ".fail")
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :nickname, :team_id, :email, :password, :password_confirmation)
  end
end
