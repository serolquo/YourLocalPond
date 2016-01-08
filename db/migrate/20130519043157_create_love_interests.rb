class CreateLoveInterests < ActiveRecord::Migration
  def change
    create_table :love_interests do |t|
      t.integer :user_id, :null => false
      t.integer :love_facebook_id, :null => false, :limit => 8

      t.timestamps
    end
    
    add_index :love_interests, [:user_id, :love_facebook_id], :unique => true
  end
end
