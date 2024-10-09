class AddReferencesToAndRemoveTeamIdFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :team_id, :integer
    add_reference :users, :team, foreign_key: true
  end
end
