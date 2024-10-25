# == Schema Information
#
# Table name: comments
#
# id                 :bigint           not null, primary key
# body               :text
# user_id            :references       foreign_key: true
# article_id         :references       foreign_key: true
# created_at         :datetime         not null
# updated_at         :datetime         not null
#

class Comment < ApplicationRecord
  validates :body, presence: true, length: { maximum: 65_535 }

  belongs_to :user
  belongs_to :article

  def self.ransackable_attributes(auth_object = nil)
    [ "article_id", "body", "created_at", "id", "updated_at", "user_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "article", "user" ]
  end
end
