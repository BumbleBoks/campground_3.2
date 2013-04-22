class CreateCornerLogs < ActiveRecord::Migration
  def change
    create_table :corner_logs do |t|
      t.integer :user_id, null: false
      t.string :title, null: false, limit: 100
      t.text :content, null: false, limit: 1000
      t.integer :activity_id
      t.date :log_date, null: false
      
      t.timestamps      
    end
    
    add_index :corner_logs, :user_id
    add_index :corner_logs, [:user_id, :activity_id]  
    add_index :corner_logs, :log_date
  end
end
  
