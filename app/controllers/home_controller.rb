class HomeController < ApplicationController
  skip_before_action :require_login, only: %i[top]
  def top; end

  def index
    @articles = Article.includes(:user)
  end
end
