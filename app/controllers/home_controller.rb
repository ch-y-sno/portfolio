class HomeController < ApplicationController
  skip_before_action :require_login, only: %i[top]
  def top; end

  def index
    @article = Article.new
    @q = Article.ransack(params[:q])
    @articles = @q.result(distinct: :true).includes(:user).order(created_at: :desc).page(params[:page])
    @topics = current_user.topics.order(created_at: :desc)
    @team = current_user.team
    @articless = Article.all.page(params[:page])
  end
end
