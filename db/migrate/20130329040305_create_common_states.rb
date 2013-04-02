class CreateCommonStates < ActiveRecord::Migration
  def change
    create_table :common_states do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
