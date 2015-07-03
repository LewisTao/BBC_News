require 'rails_helper'

RSpec.describe Article, type: :model do
  before { @artice = FactoryGirl.create :article }
  subject { @artice }

  # Default attributes
  it { should respond_to(:title) }
  it { should respond_to(:description) }

  it { should be_valid }

  # Attributes Validate
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  # Association
  it { should belong_to(:author) }


end
