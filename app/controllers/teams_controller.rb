class TeamsController < ApplicationController
  def index
    @teams = Team.order(created_at: :desc)
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.build(team_params)
    @team.leader_user_id = current_user.id
    if @team.save
      current_user.update(team_id: @team.id)
      redirect_to teams_path, success: t("defaults.flash_message.created", item: Team.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_message.not_created", item: Team.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @team = Team.find(params[:id])
    @team_leader = User.find(@team.leader_user_id)
    @team_members = @team.users
  end

  def edit
    @team = current_user.team
    @member_requests = @team.member_requests.where(approval_status: "pending")
    if @member_requests.present?
      @member_requests = @member_requests.order(created_at: :desc)
    end
  end

  def update
    @team = current_user.team
    if @team.update(team_params)
      redirect_to team_path(@team), success: t("defaults.flash_message.updated", item: Team.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_message.not_updated", item: Team.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def team_params
    params.require(:team).permit(:name, :description, :max_members, :topic_order, :topic_frequency, :topic_post_time, :topic_post_time_manual, :note, :team_avatar, :team_avatar_cache)
  end
end
