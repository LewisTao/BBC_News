require 'rails_helper'

describe ArticleDecorator do
  before(:each) do
    @author = FactoryGirl.create :author
    @article = FactoryGirl.create :article, author_id: @author.id
    @article_images = FactoryGirl.create :article_image, author_id: @author.id, article_id: @article.id
  end
  describe "show article" do
    it "should return correct article attributes" do
      #byebug
      expect_hash_eq(@article.decorate.article_show, {id: @article.id, title: @article.title, description: @article.description, author: {name: @author.name}, article_images: [{image_file_name: @article_images.image_file_name}]} )
    end
  end
end
