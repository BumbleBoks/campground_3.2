class AddIndexToTrails < ActiveRecord::Migration
  def change
    add_column :common_trails, :state_id, :integer
    add_index :common_trails, :state_id
  end
end
