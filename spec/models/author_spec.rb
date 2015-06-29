require 'rails_helper'

RSpec.describe Author, type: :model do
  before { @author = FactoryGirl.build :author }
  subject { @author }

  # Default responde
  it { should respond_to(:email) }
  it { should respond_to(:name) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  # Attribute  validate
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name)}
  it { should validate_uniqueness_of(:email)}
  it { should validate_confirmation_of(:password) }
  it {should allow_value('example@domain.com').for(:email)}
end
