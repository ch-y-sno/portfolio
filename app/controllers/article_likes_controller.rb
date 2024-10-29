class ArticleLikesController < ApplicationController
  def create
    article = Article.find(params[:article_id])
    current_user.article_like(article)
    @team = Team.find(params[:id])
    redirect_to team_path(@team), success: t(".success")
  end

  def destroy
    article = current_user.article_likes.find(params[:id]).article
    current_user.article_unlike(article)
    @team = Team.find(params[:id])
    redirect_to team_path(@team), success: t(".success"), status: :see_other
  end
end
