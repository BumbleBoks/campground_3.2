class AddIndexToSiteUserFavorites < ActiveRecord::Migration
  def change
    add_index :site_user_requests, :token
  end
end
