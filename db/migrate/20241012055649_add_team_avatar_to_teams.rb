class AddTeamAvatarToTeams < ActiveRecord::Migration[7.2]
  def change
    add_column :teams, :team_avatar, :string
  end
end
