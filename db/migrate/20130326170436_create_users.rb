class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login_id, null: false, limit: 50
      t.string :name, null: false, limit: 50
      t.string :email, null: false
      t.string :password_digest, null: false
      t.boolean :admin, default: false

      t.timestamps
    end
    add_index :users, :login_id, unique: true
  end
end
