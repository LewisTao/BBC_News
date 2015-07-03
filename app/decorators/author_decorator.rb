class AuthorDecorator < Draper::Decorator
  delegate_all

  def author_info
    as_json(
      only: [:id, :name, :email]
      )
  end

end
