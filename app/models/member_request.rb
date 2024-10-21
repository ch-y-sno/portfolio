# == Schema Information
#
# Table name: member_requests
#
# id                        :bigint           not null, primary key
# approval_status           :integer(enum)
# user_id                   :references       foreign_key: true
# team_id                   :references       foreign_key: true
# message_from_requester    :text
# message_from_approver     :text
# created_at                :datetime         not null
# updated_at                :datetime         not null
#

class MemberRequest < ApplicationRecord
  belongs_to :team
  belongs_to :user

  enum approval_status: { pending: 0, approved: 1, rejected: 2 }
end
