class CreateCommonTrails < ActiveRecord::Migration
  def change
    create_table :common_trails do |t|
      t.string :name, null: false, limit: 75
      t.decimal :length, precision: 5, scale: 2
      t.text :description, limit: 1000

      t.timestamps
    end
    add_index :common_trails, :name
    
  end
end
