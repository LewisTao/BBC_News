# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Sample Author Account
author_1 = FactoryGirl.create :author
author_2 = FactoryGirl.create :author

# Sample Article
10.times do
  article = FactoryGirl.create :article, author_id: author_1.id
end

10.times do
  article = FactoryGirl.create :article, author_id: author_2.id
end
