class MembersController < ApplicationController
  def index
    @team = current_user.team
    @team_leader = @team.users.find(@team.leader_user_id)
  end
end
