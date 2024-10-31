module TeamsHelper
  def applicable?(team)
    team.users.count < team.max_members
  end
end
