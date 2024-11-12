class ChangeColumnNullInTableTeams < ActiveRecord::Migration[7.2]
  def change
    change_column_null :teams, :topic_order, true
    change_column_null :teams, :topic_frequency, true
    change_column_null :teams, :topic_post_time, true
  end
end
