class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :user_id, :null => false
      t.integer :facebook_id, :null => false, :limit => 8
      t.string :gender,:null=>false
      t.string :first_name, :null=>false
      t.string :last_name, :null=>false

      t.timestamps
    end
    add_index :friends, :facebook_id
    
  end
end
