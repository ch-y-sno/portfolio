class AddIndexToTeamsName < ActiveRecord::Migration[7.2]
  def change
    add_index :teams, :name, unique: true
  end
end
