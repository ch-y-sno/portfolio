class AddMessageColumnToMemberRequests < ActiveRecord::Migration[7.2]
  def change
    add_column :member_requests, :message_from_requester, :text
    add_column :member_requests, :message_from_approver, :text
  end
end
