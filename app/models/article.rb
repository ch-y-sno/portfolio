class Article < ApplicationRecord
  validates :caption, length: { maximum: 65_535 }
  validates :is_public, presence: true
  validates :is_winner, presence: true

  enum is_public: { not_public: 0, public: 1 }
  enum is_winner: { not_winner: 0, winner: 1 }

  belongs_to :user
  belongs_to :topic
end
