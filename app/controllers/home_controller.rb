class HomeController < ApplicationController
  skip_before_action :require_login, only: %i[top]
  def top; end

  def index
    @article = Article.new
    @articles = Article.includes(:user).order(created_at: :desc)
  end
end
