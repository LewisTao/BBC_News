require 'rails_helper'

describe ArticleDecorator do
  before(:each) do
    @article = FactoryGirl.create :article
  end
  describe "show article" do
    it "should return correct article attributes" do
      expect_hash_eq(@article.decorate.article_show, {id: @article.id, title: @article.title, description: @article.description})
    end
  end
end
