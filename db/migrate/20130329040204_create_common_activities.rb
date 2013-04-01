class CreateCommonActivities < ActiveRecord::Migration
  def change
    create_table :common_activities do |t|
      t.string :name

      t.timestamps
    end
  end
end
