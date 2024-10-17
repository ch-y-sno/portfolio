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
  validates :note, presence: true, length: { maximum: 65_535 }

  has_one :team_leader, dependent: :destroy
  has_many :topics
  has_many :users

  mount_uploader :team_avatar, TeamAvatarUploader
end
