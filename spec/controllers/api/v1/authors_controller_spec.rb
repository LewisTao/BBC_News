require 'rails_helper'

RSpec.describe Api::V1::AuthorsController, type: :controller do
  # Index action
  let(:owner) { FactoryGirl.create :author }
  let(:access_token) { FactoryGirl.create(:access_token, resource_owner_id: owner.id) }

  describe "GET #index" do
    before(:each) do
      oauth_verify_token(access_token)
      #5.times do
        @author = FactoryGirl.create :author
      #end
      get :index
    end

    it "should return all author" do
      author_response= JSON.parse(response.body, symbolize_names: true)
      expect(author_response.size).to eql 2
    end
  end

  # Show action
  describe "GET #show" do
    before(:each) do
      oauth_verify_token(access_token)
      @author = FactoryGirl.create :author
      get :show, id: @author.id
    end

    it "should return correct author information" do
      author_response = JSON.parse(response.body, symbolize_names: true)
      expect_hash_eq(author_response, {id: @author.id, email: @author.email, name: @author.name})
    end
  end

  # Create action
  describe "POST #create" do
    # Success create new Author
    context "Success create new Author" do
      before(:each) do
        @author_attributes = FactoryGirl.attributes_for :author
        post :create, authors: @author_attributes
      end

      it "return author attributes just created" do
          author_response = JSON.parse(response.body, symbolize_names: true)
          expect(author_response[:email]).to eql @author_attributes[:email]
      end
    end
    # Un-success create new Author
    context "Un-success create new Author" do
      before(:each) do
        @invalid_attributes = FactoryGirl.attributes_for :author, email: 'abc'
        post :create, authors: @invalid_attributes
      end

      it "return errors on a hash" do
        author_response = JSON.parse(response.body, symbolize_names: true)
        expect(author_response).to have_key(:errors)
      end

      it "return full errors messages" do
        author_response = JSON.parse(response.body, symbolize_names: true)
        expect(author_response[:errors][:email]).to include('wrong email address')
      end
    end
  end
end
