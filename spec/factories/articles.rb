FactoryGirl.define do
  factory :article do
    title {FFaker::Product.product_name}
    description {FFaker::HipsterIpsum.paragraphs}
    author_id {FFaker::SSNSE.ssn}
  end

end
