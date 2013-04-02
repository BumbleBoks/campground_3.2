class CreateCommonActivityAssociations < ActiveRecord::Migration
  def change
    create_table :common_activity_associations do |t|
      t.integer :activity_id, null: false
      t.integer :trail_id, null: false

      t.timestamps
    end
    
    add_index :common_activity_associations, :activity_id
    add_index :common_activity_associations, :trail_id
    add_index :common_activity_associations, [:activity_id, :trail_id], unique: true
    
  end
end
