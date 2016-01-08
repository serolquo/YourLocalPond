class AddFbPicUrlToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :fb_pic_url, :string
  end
end
