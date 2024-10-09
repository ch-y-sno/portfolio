class ArticlesController < ApplicationController
  def index # いらない？
    @articles = Article.includes(:user).order(created_at: :desc)
  end

  def new # いらない？
    @article = Article.new
    @article_image = session[:uploaded_file]
  end

  def create
    @article = current_user.articles.build(image_params)
    if @article.save
      redirect_to edit_article_path(@article) #, success: t('defaults.flash_message.created', item: Article.model_name.human)
    end
  end

  def edit
    @article = current_user.articles.find(params[:id])
  end

  def update
    @article = current_user.articles.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article), success: t("defaults.flash_message.updated", item: Article.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_message.not_updated", item: Article.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comments = @article.comments.includes(:user).order(created_at: :desc)
  end

  private

  def image_params
    params.require(:article).permit(:article_image, :article_image_cache)
  end

  def article_params
    params.require(:article).permit(:caption, :article_image, :article_image_cache)
  end
end
