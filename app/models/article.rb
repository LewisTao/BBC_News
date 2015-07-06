class Article < ActiveRecord::Base
  # Defautle attributes
  validates_presence_of :title, :description, :author_id

  # Association
  belongs_to :author
end
