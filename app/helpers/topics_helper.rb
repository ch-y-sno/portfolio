module TopicsHelper
  def articles_sorted_by_likes(articles)
    articles.sort_by { |article| -article.article_likes.count }
  end
end
