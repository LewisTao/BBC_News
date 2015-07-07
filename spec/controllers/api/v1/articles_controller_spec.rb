require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do
  # Index action
  let(:owner) { FactoryGirl.create :author }
  let(:access_token) { FactoryGirl.create :access_token, resource_owner_id: owner.id }
  describe "GET #index" do
    before(:each) do
      oauth_verify_token(access_token)
      21.times do
        @article = FactoryGirl.create :article, author_id: owner.id
      end
      get :index, page: 5

    end

    it "should return all article with pagination" do
      article_response= JSON.parse(response.body, symbolize_names: true)
      expect(article_response.count).to eql 1
    end
  end

  # Show action
  describe "GET #show" do
    before(:each) do
      oauth_verify_token(access_token)
      @article = FactoryGirl.create(:article, author_id: owner.id)
      get :show, id: @article.id
    end

    it "should return correct article" do
      article_response = JSON.parse(response.body, symbolize_names: true)
      expect(article_response).to eql(id: @article.id, title: @article.title, description: @article.description, author: {name: owner.name})
    end
  end

  # Create action
  describe "POST #create" do
    let(:owner) { FactoryGirl.create :author }
    let(:access_token)  { FactoryGirl.create :access_token, resource_owner_id: owner.id }

    # Success create new article
    context "Success create new article" do
      before(:each) do
        oauth_verify_token(access_token)
        @article_attributes = FactoryGirl.attributes_for :article, author_id: owner.id
        post :create, articles: @article_attributes, author_id: owner.id
      end

      it "should return new article just created" do
        article_response = JSON.parse(response.body, symbolize_names: true)
        expect(article_response).to include(title: @article_attributes[:title], description: @article_attributes[:description], author: {name: owner.name})
      end
    end

    # Can not create new article
    context "Can not create new article" do
      before(:each) do
        oauth_verify_token(access_token)
        @invalid_attributes = FactoryGirl.attributes_for :article, author_id: owner.id, title: " "
        post :create, author_id: owner.id, articles: @invalid_attributes
      end

      #it "should return errors key" do
        #article_response = JSON.parse(response.body, symbolize_names: true)
        #expect(article_response).to have_key(:errors)
      #end

      it "should return full errors message" do
        article_response = JSON.parse(response.body, symbolize_names: true)
        #expect(article_response[:errors][:title]).to include( "can't be blank")
        expect(article_response[:title]).to include( "can't be blank")
      end
    end
  end

# Update action
  describe "PUT #update" do
    let(:owner) { FactoryGirl.create :author }
    let(:access_token) { FactoryGirl.create :access_token, resource_owner_id: owner.id }

    # Success update article
    context "success update article" do
      before(:each) do
        oauth_verify_token(access_token)
        @article = FactoryGirl.create :article, author_id: owner.id
        put :update, {id: @article.id, author_id: owner.id, articles: {title: "New title"} }
      end
      it "should return article just updated" do
        article_response = JSON.parse(response.body, symbolize_names: true)
        expect(article_response[:title]).to eql("New title")
      end
    end

    # Can not update article
    context "can not update article" do
      before(:each) do
        oauth_verify_token(access_token)
        @article = FactoryGirl.create :article, author_id: owner.id
        put :update, { id: @article.id, author_id: owner.id, articles: {title: " "} }
      end

      it "should return errors key" do
        article_response = JSON.parse(response.body, symbolize_names: true)
        expect(article_response).to have_key(:errors)
      end

      it "should return full errors message" do
        article_response = JSON.parse(response.body, symbolize_names: true)
        expect(article_response[:errors][:title]).to include("can't be blank")
      end
    end
  end

  describe "DELETE #destroy" do
    let(:owner) { FactoryGirl.create :author }
    let(:access_token) { FactoryGirl.create :access_token, resource_owner_id: owner.id }


    before(:each) do
      oauth_verify_token(access_token)
      @article = FactoryGirl.create :article, author_id: owner.id
      delete :destroy, id: @article.id, author_id: owner.id
    end

    it { should respond_with 204 }
  end
end
