# == Schema Information
#
# Table name: member_requests
#
# id                        :bigint           not null, primary key
# title                     :string           not null
# description               :text             not null
# user_id                   :references       foreign_key: true
# team_id                   :references       foreign_key: true
# created_at                :datetime         not null
# updated_at                :datetime         not null
#

class Topic < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 65_535 }

  belongs_to :user
  belongs_to :team
  has_many :articles

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "description", "id", "id_value", "team_id", "title", "updated_at", "user_id" ]
  end
end
