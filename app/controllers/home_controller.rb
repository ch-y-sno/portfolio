class HomeController < ApplicationController
  skip_before_action :require_login, only: %i[top]
  def top; end

  def index
    @q = Article.ransack(params[:q])
    @topics = current_user.topics.order(created_at: :desc).page(params[:topics]).per(5)
    @team = current_user.team
    @my_articles = current_user.articles.includes([ { user: :team }, :topic, :article_likes ]).ransack(params[:q]).result(distinct: :true).order(created_at: :desc).page(params[:my_articles])
  end
end
