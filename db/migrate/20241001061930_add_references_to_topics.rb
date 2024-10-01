class AddReferencesToTopics < ActiveRecord::Migration[7.2]
  def change
    add_reference :topics, :team, foreign_key: true
  end
end
