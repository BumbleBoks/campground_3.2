class CreateCommonStates < ActiveRecord::Migration
  def change
    create_table :common_states do |t|
      t.string :name

      t.timestamps
    end
  end
end
