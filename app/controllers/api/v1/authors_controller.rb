class Api::V1::AuthorsController < ApplicationController
  def index
    author = Author.all
    render json: author
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
