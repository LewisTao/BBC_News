class ArticleDecorator < Draper::Decorator
  delegate_all

  def article_show
    as_json(
      only: [:id, :title, :description],
      include: {author: {only: [:name]},
                article_images: {only: [:image_file_name]}}
    )
  end
end
