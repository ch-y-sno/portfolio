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
end
