class TopicsController < ApplicationController
  def new
    @team = Team.find(params[:team_id])
    @topic = Topic.new
  end

  def create
    @team = Team.find(params[:team_id])
    @topic = Topic.build(topic_params)
    if @topic.save
      redirect_to team_members_path(@team), success: t("defaults.flash_message.created", item: Topic.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_message.not_created", item: Topic.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @team = Team.find(params[:team_id])
    @topics = @team.topics.order(created_at: :desc)
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

  def topic_params
    params.require(:topic).permit(:title, :description).merge(user_id: current_user.id, team_id: params[:team_id])
  end
end
