class CreateMemberRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :member_requests do |t|
      t.integer :approval_status
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
