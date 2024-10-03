# == Schema Information
#
# Table name: articles
#
# id               :bigint           not null, primary key
# image_url        :string           not null
# caption          :text
# user_id          :references       foreign_key: true
# topic_id         :references       foreign_key: true
# is_public        :integer(enum)    not null, default: 0
# is_winner        :integer(enum)    not null, default: 0
# created_at       :datetime         not null
# updated_at       :datetime         not null
#

class Article < ApplicationRecord
  validates :caption, length: { maximum: 65_535 }
  validates :is_public, presence: true
  validates :is_winner, presence: true

  enum is_public: { published_article: 0, private_article: 1 }
  enum is_winner: { participant: 0, winner: 1 }

  belongs_to :user
  # will delete optional later on
  belongs_to :topic, optional: true
end
