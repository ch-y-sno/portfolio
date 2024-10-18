class MemberRequestsController < ApplicationController
  def index
    @team = Team.find(params[:team_id])
    @team_leader = User.find(@team.leader_user_id)
    @availability = @team.max_members - @team.users.count
  end
end
