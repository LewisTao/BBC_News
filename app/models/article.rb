class Article < ActiveRecord::Base
  # Defautle attributes
  validates_presence_of :title, :description, :author_id

  # Association
  belongs_to :author
  has_many :article_images, dependent: :destroy

  # Nested Attributes
  attr_accessor :article_images_attributes
  accepts_nested_attributes_for :article_images  #, :reject_if => lambda { |image| image['article_image'].nil? }
end
