class MemberRequestsController < ApplicationController
  def new
    @team = Team.includes(:users).find(params[:team_id])
    @team_leader = User.find(@team.leader_user_id)
    @availability = @team.max_members - @team.users.count
    @member_request = MemberRequest.new
  end

  def create
    @team = Team.includes(:users).find(params[:team_id])
    @team_leader = User.find(@team.leader_user_id)
    if current_user.member_requests.present?
      if current_user.member_requests.last.approval_status == "rejected"
        @member_request = current_user.member_requests.build(member_request_params)
        @member_request.approval_status = 0
        if @member_request.save
          redirect_to team_path(@team), success: t("defaults.flash_message.requested", item: @team.name)
        else
          flash.now[:danger] = t("defaults.flash_message.request_failed", item: @team.name)
          render :new, status: :unprocessable_entity
        end
      else
        redirect_to team_path(@team), danger: t("defaults.flash_message.one_request_only")
      end
    else
      @member_request = current_user.member_requests.build(member_request_params)
      @member_request.approval_status = 0
      if @member_request.save
        redirect_to team_path(@team), success: t("defaults.flash_message.requested", item: @team.name)
      else
        flash.now[:danger] = t("defaults.flash_message.request_failed", item: @team.name)
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
    @team = Team.find(params[:team_id])
    @member_request = MemberRequest.find(params[:id])
    @requester = @member_request.user
  end

  def update
    @team = Team.find(params[:team_id])
    @member_request = MemberRequest.find(params[:id])
    @no_of_team_members = @team.users.count
    @requester = @member_request.user
    if @member_request.update(member_request_params)
      if @member_request.approved?
        if @no_of_team_members == @team.max_members
          flash.now[:danger] = t("defaults.flash_message.exceeds_max_members", item: Team.model_name.human)
          render :edit, status: :unprocessable_entity
        else
          @requester.update(team_id: @team.id)
          redirect_to team_path(@team), success: t("defaults.flash_message.decided", item1: @requester.decorate.full_name, item2: t("member_requests.approval_status.#{@member_request.approval_status}"))
        end
      else
        redirect_to team_path(@team), success: t("defaults.flash_message.decided", item1: @requester.decorate.full_name, item2: t("member_requests.approval_status.#{@member_request.approval_status}"))
      end
    else
      flash.now[:danger] = t("defaults.flash_message.not_updated", item: Team.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def member_request_params
    params.require(:member_request).permit(:message_from_requester, :message_from_approver, :approval_status).merge(team_id: params[:team_id])
  end
end
