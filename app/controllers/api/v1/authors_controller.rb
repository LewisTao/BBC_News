class Api::V1::AuthorsController < Api::V1::BaseController
  before_action :doorkeeper_authorize!, except: [:create]

  def index
    authors = Author.all
    render json: authors.map { |a| a.decorate.author_info }
  end

  def create
    author = Author.new(authors_params)
    if author.save
      render json: author
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
