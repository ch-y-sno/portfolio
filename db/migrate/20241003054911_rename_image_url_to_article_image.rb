class RenameImageUrlToArticleImage < ActiveRecord::Migration[7.2]
  def change
    rename_column :articles, :image_url, :article_image
  end
end
