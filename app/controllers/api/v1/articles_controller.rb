class Api::V1::ArticlesController < ApplicationController
  #before_action :authenticate_with_token!

  def index
    articles= Article.all.order('created_at DESC')
    render json: articles
  end

  def show
    article = Article.find_by(id: params[:id])
    render json: article.decorate.article_show
  end

  def create
    article = current_author.articles.build(articles_params)

    if article.save
      render json: article.decorate.article_show
    else
      render json: { errors: article.errors }
    end
  end

  private
  def articles_params
    params.require(:article).permit(:title, :description)
  end

end
