class CreateArticleImages < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :article_images, id: :uuid do |t|
      t.string :article_id
      t.string :author_id

      t.timestamps null: false
    end
    add_index :article_images, :article_id
    add_index :article_images, :author_id
  end
end
