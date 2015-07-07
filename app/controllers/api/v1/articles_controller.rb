class Api::V1::ArticlesController < Api::V1::BaseController
  before_action :doorkeeper_authorize!, except: [:index, :show]
  def index
    articles = Article.order('created_at DESC').page(params[:page]).per_page(5)
    render json: articles.map { |a| a.decorate.article_show }
  end

  def show
    article = Article.find(params[:id])
    render json: article.decorate.article_show
  end

  def create

    article = ArticleService.create_article_and_image(articles_params, current_author, images_params)
    render json: article
  end

  def update
    article = ArticleService.update_article_and_image(articles_params, current_author, images_params)
    render json: article
  end

  def destroy
    article = current_author.articles.find(params[:id])
    article.destroy
    head 204
  end

  private

  def articles_params
    params.require(:articles).permit(:title, :description)
  end

  def images_params
    params.require(:article_images).permit(:image)
  end

end
