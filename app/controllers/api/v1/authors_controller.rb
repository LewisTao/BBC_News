class Api::V1::AuthorsController < Api::V1::BaseController
  def index
    authors = Author.all
    render json: authors
  end

  def create
    author = Author.new(authors_params)
    if author.save
      render json: author.decorate.author_info
    else
      render json: { errors: author.errors }
    end
  end

  def show
    author = Author.find_by(id: params[:id])
    render json: author.decorate.author_info
  end

  private
  def authors_params
    params.require(:authors).permit(:email, :password_confirmation, :password, :name)
  end
end
