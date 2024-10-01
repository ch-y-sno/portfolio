class AddReferencesToArticles < ActiveRecord::Migration[7.2]
  def change
    add_reference :articles, :topic, foreign_key: true
  end
end
