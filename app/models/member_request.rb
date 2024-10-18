# == Schema Information
#
# Table name: articles
#
# id               :bigint           not null, primary key
# approval_status  :integer(enum)
# user_id          :references       foreign_key: true
# team_id          :references       foreign_key: true
# created_at       :datetime         not null
# updated_at       :datetime         not null
#

class MemberRequest < ApplicationRecord
  belongs_to :team
  belongs_to :user
  enum approval_status: { approved: 0, rejected: 1 }
end
