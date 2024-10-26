# == Schema Information
#
# Table name: teams
#
#  id                          :bigint           not null, primary key
#  name                        :string           not null
#  description                 :text             not null
#  max_members                 :integer          not null, default: 10
#  topic_order                 :text             not null
#  topic_frequency             :integer          not null
#  topic_post_time             :time             not null
#  topic_post_time_manual      :datetime
#  note                        :text
#  leader_user_id              :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#
#
# Indexes
#
#

class Team < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 65_535 }
  validates :max_members, presence: true
  validates :topic_order, presence: true
  validates :topic_frequency, presence: true
  validates :topic_post_time, presence: true
  validates :topic_post_time, length: { maximum: 255 }
  validates :note, length: { maximum: 65_535 }

  has_many :topics
  has_many :users
  has_many :member_requests
  belongs_to :team_leader, class_name: "User", foreign_key: "leader_user_id", optional: true

  mount_uploader :team_avatar, TeamAvatarUploader

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "description", "id", "id_value", "leader_user_id", "max_members", "name", "note", "team_avatar", "topic_frequency", "topic_order", "topic_post_time", "topic_post_time_manual", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "member_requests", "team_leader", "topics", "users" ]
  end
end
