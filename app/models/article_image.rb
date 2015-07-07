class ArticleImage < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "320x480>", :thumb => "150x150>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  # Association
  belongs_to :article
  belongs_to :author
end
