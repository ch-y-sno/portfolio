class ArticlesController < ApplicationController
  def index
    @articles = Article.includes(:user)
  end

  def new # いらない？
    @article = Article.new
    @article_image = session[:uploaded_file]
  end

  def create
    @article = current_user.articles.build(image_params)
    if @article.save
      redirect_to edit_article_path(@article) # , success: t('defaults.flash_message.created', item: Article.model_name.human)
    end
  end

  def edit
    @article = current_user.articles.find(params[:id])
  end

  def update
    @article = current_user.articles.find(params[:id])
    if @article.save
      redirect_to edit_article_path(@article), success: t("defaults.flash_message.updated", item: Article.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_message.not_updated", item: Article.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def image_params
    params.require(:article).permit(:article_image, :article_image_cache)
  end
end
