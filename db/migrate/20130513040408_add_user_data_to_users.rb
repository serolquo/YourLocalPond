class AddUserDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_id, :bigint
    add_column :users, :gender, :string
    add_column :users, :interested_in, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :time_zone, :int
    add_column :users, :locale, :string
  end
end
