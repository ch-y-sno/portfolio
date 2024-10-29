# == Schema Information
#
# Table name: articles
#
# id               :bigint           not null, primary key
# article_image    :string           not null
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
  has_many :comments, dependent: :destroy
  has_many :article_likes, dependent: :destroy

  mount_uploader :article_image, ArticleImageUploader

  def self.ransackable_attributes(auth_object = nil)
    [ "article_image", "caption", "created_at", "id", "id_value", "is_public", "is_winner", "topic_id", "updated_at", "user_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "comments", "topic", "user" ]
  end
end
