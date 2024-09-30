class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show update edit]

  def show; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: t("defaults.flash_message.profile_updated", item: User.model_name.human)
    else
      flash.now["danger"] = t("defaults.flash_message.profile_not_updated", item: User.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def edit; end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :nickname, :team_id, :email, :password, :password_confirmation, :age, :gender, :bio, :avatar, :avatar_cache)
  end
end
