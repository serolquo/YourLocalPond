class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :first_user_id, :null => false
      t.integer :second_user_id, :null => false
      t.string :email_sent,:null=>false, :default=>'n'
      t.datetime :match_date, :null=>false

      t.timestamps
    end
  end
end
