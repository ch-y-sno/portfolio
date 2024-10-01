class CreateTeams < ActiveRecord::Migration[7.2]
  def change
    create_table :teams do |t|
      t.string :name,                       null: false
      t.text :description,                  null: false
      t.integer :max_members,               null: false, default: 10
      t.text :topic_order,                  null: false
      t.integer :topic_frequency,           null: false
      t.time :topic_post_time,              null: false
      t.datetime :topic_post_time_manual
      t.text :note

      t.timestamps
    end
  end
end
