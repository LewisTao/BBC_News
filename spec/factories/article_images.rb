include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :article_image do
    #article_id {FFaker::SSNSE.ssn}
    #author_id {FFaker::SSNSE.ssn}
    image {fixture_file_upload(Rails.root.join('spec/fixtures/files/anime_kyu_cover.png'), 'image/png')}
  end

end
