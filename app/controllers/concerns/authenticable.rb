module Authenticable
  # Overwrite devise current user
  def current_author
    @current_author ||= Author.find_by(auth_token: request.headers['Authorization'])
  end


  def authenticate_with_token!
    render json: { errors: "Not authenticate" } unless author_logined_in?
  end

  def author_logined_in?
    current_author.present?
  end

end
