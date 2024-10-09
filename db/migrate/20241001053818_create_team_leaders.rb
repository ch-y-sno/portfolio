class CreateTeamLeaders < ActiveRecord::Migration[7.2]
  def change
    create_table :team_leaders do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
