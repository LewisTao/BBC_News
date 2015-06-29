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

  # Before filter
  before_create :email_downcase
  before_create :generate_authenticate_token!

  # Custom Method
  def generate_authenticate_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  private

  def email_downcase
    email.downcase! if email.present?
  end
end
