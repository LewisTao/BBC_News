require 'rails_helper'

RSpec.describe Api::V1::AuthorsController, type: :controller do
  # Index action
  describe "GET #index" do
    before(:each) do
      5.times do
        @author = FactoryGirl.create :author
      end
      get :index
    end

    it "should return all author" do
      author_response= JSON.parse(response.body, symbolize_name: true)
      expect(author_response.size).to eql 5
    end
  end

  # Show action
  describe "GET #show" do
    before(:each) do
      @author = FactoryGirl.create :author
      get :show, id: @author.id
    end

    it "should return correct author information" do
      author_response = JSON.parse(response.body, symbolize_name: true)
      expect_hash_eq(author_response, {id: @author.id, email: @author.email, name: @author.name})
    end
  end
end
