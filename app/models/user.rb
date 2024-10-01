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
#  team_id          :integer
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

  mount_uploader :avatar, AvatarUploader
end
