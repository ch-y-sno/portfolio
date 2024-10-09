class CreateArticles < ActiveRecord::Migration[7.2]
  def change
    create_table :articles do |t|
      t.string :image_url,   null: false
      t.text :caption
      t.references :user, foreign_key: true
      t.integer :is_public, null: false, default: 0
      t.integer :is_winner, null: false, default: 0

      t.timestamps
    end
  end
end
