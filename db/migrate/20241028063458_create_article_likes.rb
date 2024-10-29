class CreateArticleLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :article_likes do |t|
      t.references :user, foreign_key: true
      t.references :article, foreign_key: true

      t.timestamps
    end
    add_index :article_likes, [ :user_id, :article_id ], unique: true
  end
end
