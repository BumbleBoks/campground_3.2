class AddIndexToCommonActivitiesName < ActiveRecord::Migration
  def change
    add_index :common_activities, :name, unique: true
    add_index :common_states, :name, unique: true
  end
end
