require 'rails_helper'

describe AuthorDecorator do
  describe "author info" do
    before(:each) do
      @author = FactoryGirl.create :author
    end

    it "should return correct attributes" do
      expect_hash_eq(@author.decorate.author_info, { id: @author.id, email: @author.email, name: @author.name })
    end
  end

end
