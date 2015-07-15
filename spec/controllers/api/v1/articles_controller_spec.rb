require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do
  # Index action
  let(:owner) { FactoryGirl.create :author }
  #let(:access_token) { FactoryGirl.create :access_token, resource_owner_id: owner.id }
  describe "GET #index" do
    before(:each) do
      #oauth_verify_token(access_token)
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
      #oauth_verify_token(access_token)
      @article = FactoryGirl.create(:article, author_id: owner.id)
      @article_image = FactoryGirl.create :article_image, author_id: owner.id, article_id: @article.id
      get :show, id: @article.id
    end

    it "should return correct article" do
      article_response = JSON.parse(response.body, symbolize_names: true)
      expect(article_response).to eql(id: @article.id, title: @article.title, description: @article.description, author: {name: owner.name}, article_images: [{image_file_name: @article_image.image_file_name}])
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
        @images_attributes = FactoryGirl.attributes_for :article_image
        @article_params = FactoryGirl.attributes_for :article, article_images_attributes: @images_attributes
        post :create, articles: @article_params, author_id: owner.id
      end

      it "should return new article just created" do
        article_response = JSON.parse(response.body, symbolize_names: true)
        expect(article_response).to include(title: @article_params[:title], description: @article_params[:description], author: {name: owner.name})
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
      context "update article with image update" do
        before(:each) do
          oauth_verify_token(access_token)
          @article = FactoryGirl.create :article, author_id: owner.id
          @images_attributes = FactoryGirl.attributes_for :article_image
          put :update, {id: @article.id, author_id: owner.id, articles: {title: "New title", article_images_attributes: @images_attributes} }
        end
        it "should return article with new title just updated" do
          article_response = JSON.parse(response.body, symbolize_names: true)
          expect(article_response[:title]).to eql("New title")
        end

        it "should update new article image" do
          article_response = JSON.parse(response.body, symbolize_names: true)
          expect(article_response[:article_images]).not_to be_empty
        end
      end
      context "update article without image update" do
        before(:each) do
          oauth_verify_token(access_token)
        @article = FactoryGirl.create :article, author_id: owner.id
        put :update, {id: @article.id, author_id: owner.id, articles: {title: 'New title'}}
        end

        it "should return article with correct attirbutes just updated" do
          article_response = JSON.parse(response.body, symbolize_names: true)
          expect(article_response[:title]).to eql('New title')
        end
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
