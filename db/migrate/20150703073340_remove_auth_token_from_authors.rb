class RemoveAuthTokenFromAuthors < ActiveRecord::Migration
  def change
    remove_column :authors, :auth_token, :string
  end
end
