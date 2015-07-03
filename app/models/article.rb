class Article < ActiveRecord::Base
  # Defautle attributes
  validates_presence_of :title, :description

  # Association
  belongs_to :author
end
