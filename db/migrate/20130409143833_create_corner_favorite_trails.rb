class CreateCornerFavoriteTrails < ActiveRecord::Migration
  def change
    create_table :corner_favorite_trails do |t|
      t.integer :user_id, null: false
      t.integer :trail_id, null: false

      t.timestamps
    end
    add_index :corner_favorite_trails, :user_id
    add_index :corner_favorite_trails, :trail_id
    add_index :corner_favorite_trails, [:user_id, :trail_id], unique: true    
  end
end
