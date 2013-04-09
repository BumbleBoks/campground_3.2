class AddIndexToCommunityUpdates < ActiveRecord::Migration
  def change
    add_index :community_updates, :created_at
  end
end
