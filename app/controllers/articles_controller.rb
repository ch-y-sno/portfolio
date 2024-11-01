class ArticlesController < ApplicationController
  def index
    @q = Article.ransack(params[:q])
    @articles = @q.result(distinct: :true).includes(:user).order(created_at: :desc).page(params[:page])
    @my_articles = current_user.articles.ransack(params[:q]).result(distinct: :true).order(created_at: :desc).page(params[:page])
    @topics = current_user.topics.order(created_at: :desc)
  end

  def new
    @article = Article.new
    @article_image = session[:uploaded_file]
    @topic = Topic.find(params[:topic_id])
    @team = Team.find(params[:team_id])
  end

  def create
    @team = current_user.team
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to team_path(@team), success: t("defaults.flash_message.created", item: Article.model_name.human)
    else
      flashs.now[:danger] = t("defaults.flash_message.not_created", item: Article.model_name.human)
      render :new, status: :unprocessable_entity
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

  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy!
    redirect_to home_path, success: t("defaults.flash_message.deleted", item: Article.model_name.human)
  end

  def upload_image
    render :new
  end

  def article_likes
    @q = current_user.like_articles.ransack(params[:q])
    @like_articles = @q.result(distinct: :true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  private

  def article_params
    params.require(:article).permit(:caption, :article_image, :article_image_cache).merge(topic_id: params[:topic_id])
  end
end
