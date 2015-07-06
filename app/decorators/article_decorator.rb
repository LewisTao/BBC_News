class ArticleDecorator < Draper::Decorator
  delegate_all

  def article_show
    as_json(
      only: [:id, :title, :description],
      include: {author: {only: [:name]}}
    )
  end

end
