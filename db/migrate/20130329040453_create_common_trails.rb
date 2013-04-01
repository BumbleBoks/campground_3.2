class CreateCommonTrails < ActiveRecord::Migration
  def change
    create_table :common_trails do |t|
      t.string :name
      t.decimal :length
      t.text :description

      t.timestamps
    end
  end
end
