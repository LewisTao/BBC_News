require 'rails_helper'

RSpec.describe Article, type: :model do
  before { @article = FactoryGirl.create :article }
  subject { @article }

  # Default attributes
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:author_id) }


  it { should be_valid }

  # Attributes Validate
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:author_id) }


  # Association
  it { should belong_to(:author) }


end
