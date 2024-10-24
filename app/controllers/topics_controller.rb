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

  def edit
    @team = current_user.team
    @member_requests = @team.member_requests.where(approval_status: "pending")
    @topic = current_user.topics.find(params[:id])
    if @member_requests.present?
      @member_requests = @member_requests.order(created_at: :desc)
    end
  end

  def update
    @topic = current_user.topics.find(params[:id])
    if @topic.update(topic_params)
      redirect_to home_path, success: t("defaults.flash_message.updated", item: Topic.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_message.not_updated", item: Topic.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy!
  end


  private

  def topic_params
    params.require(:topic).permit(:title, :description).merge(user_id: current_user.id, team_id: params[:team_id])
  end
end
