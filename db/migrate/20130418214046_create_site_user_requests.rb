class CreateSiteUserRequests < ActiveRecord::Migration
  def change
    create_table :site_user_requests do |t|
      t.string :email, null: false
      t.string :token, null: false
      t.string :request_type, null: false

      t.timestamps
    end
    add_index :site_user_requests, :email 
    add_index :site_user_requests, :created_at 
  end
end
