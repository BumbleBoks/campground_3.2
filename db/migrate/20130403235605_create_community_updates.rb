class CreateCommunityUpdates < ActiveRecord::Migration
  def change
    create_table :community_updates do |t|
      t.text :content, null: false, limit: 500
      t.integer :author_id, null: false
      t.integer :trail_id, null: false

      t.timestamps
    end
    add_index :community_updates, :author_id
    add_index :community_updates, :trail_id
  end
end
