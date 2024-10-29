# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  email            :string           not null, unique
#  crypted_password :string(8~255)
#  salt
#  first_name       :string(255)      not null
#  last_name        :string(255)      not null
#  nickname         :string(255)      not null, unique
#  team_id          :references       foreign_key: true
#  age              :integer
#  gender           :integer
#  bio              :text
#  avatar           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email       (email)
#

class User < ApplicationRecord
  include CryptedPassword

  authenticates_with_sorcery!

  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :nickname, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :age, length: { maximum: 255 }
  validates :gender, length: { maximum: 255 }
  validates :bio, length: { maximum: 65_535 }

  enum gender: { male: 0, female: 1 }

  has_many :articles, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_one :member_request
  belongs_to :team, optional: true
  has_many :comments, dependent: :destroy
  has_many :article_likes, dependent: :destroy
  has_many :like_articles, through: :article_likes, source: :article

  mount_uploader :avatar, AvatarUploader

  def own?(object)
    id == object&.user_id
  end

  def article_like(article)
    like_articles << article
  end

  def article_unlike(article)
    like_articles.destroy(article)
  end

  def article_like?(article)
    like_articles.include?(article)
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "age", "avatar", "bio", "created_at", "first_name", "gender", "id", "id_value", "last_name", "nickname", "team_id", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "articles", "comments", "member_request", "team", "topics" ]
  end
end
