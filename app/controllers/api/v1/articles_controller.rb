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

    article = current_author.articles.build(articles_params)
    article_image = article.article_images.build(articles_params[:article_images_attributes])
    article_image.author_id = current_author.id
    if article.save
      render json: article.decorate.article_show
    else
      render json: article.errors
    end
  end

  def update
    article = Article.find_by!(id: params[:id])
    if article.update(articles_params)
      render json: article.decorate.article_show
    else
      render json: {errors: article.errors}
    end
  end

  def destroy
    article = current_author.articles.find(params[:id])
    article.destroy
    head 204
  end

  private

  def articles_params
    params.require(:articles).permit(:title, :description, article_images_attributes: [:image])
  end

end
