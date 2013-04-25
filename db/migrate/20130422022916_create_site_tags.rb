class CreateSiteTags < ActiveRecord::Migration
  def change
    create_table :site_tags do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :site_tags, :name, unique: true
  end
end
