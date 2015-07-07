class ArticleService < Api::V1::BaseController
  class << self
    # Only update 1 Image per times
    def create_article_and_image(articles_params, current_author, images_params)
      article = current_author.articles.build(articles_params)
      article.article_images.build(images_params.merge!(author_id: current_author.id) )
      if article.save
        return article.decorate.article_show
      else
        return article.errors
      end
    end

    def update_article_and_image(articles_params, current_author, images_params)

    end

  end

end
