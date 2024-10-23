class AddLeaderUserIdToTeams < ActiveRecord::Migration[7.2]
  def change
    add_column :teams, :leader_user_id, :integer
  end
end
