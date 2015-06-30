class CreateArticles < ActiveRecord::Migration
  def change
enable_extension 'uuid-ossp'

    create_table :articles, id: :uuid do |t|
      t.string :title
      t.text :description
      t.string :author_id

      t.timestamps null: false
    end
    add_index :articles, :author_id
  end
end
