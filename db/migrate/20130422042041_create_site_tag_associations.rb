class CreateSiteTagAssociations < ActiveRecord::Migration
  def change
    create_table :site_tag_associations do |t|
      t.integer :tag_id, null: false
      t.integer :associated_id, null: false
      t.string :type, null: false

      t.timestamps
    end
    
    add_index :site_tag_associations, :tag_id
    add_index :site_tag_associations, [:associated_id, :type], name: 'by_associated_item'
    add_index :site_tag_associations, [:tag_id, :associated_id, :type], unique: true, 
      name: 'by_tag_in_associated_item'
    
  end
end
