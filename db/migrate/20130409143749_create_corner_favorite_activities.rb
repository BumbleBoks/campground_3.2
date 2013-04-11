class CreateCornerFavoriteActivities < ActiveRecord::Migration
  def change
    create_table :corner_favorite_activities do |t|
      t.integer :user_id, null: false
      t.integer :activity_id, null: false

      t.timestamps
    end
    add_index :corner_favorite_activities, :user_id
    add_index :corner_favorite_activities, :activity_id
    add_index :corner_favorite_activities, [:user_id, :activity_id], unique: true
  end
end
