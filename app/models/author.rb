class Author < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Attribute validate
  validates_presence_of :email, :name
  validates_uniqueness_of :email
  validates_confirmation_of :password
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, :message => 'wrong email address'

  # Association
  has_many :articles
  has_many :article_images

  # Before filter
  before_create :email_downcase

  def self.authenticate(params)
    credentials = params.slice(:email, :password)
    find_for_database_authentication(credentials)
  end

  private

  def email_downcase
    email.downcase! if email.present?
  end
end
