class Match < ActiveRecord::Base
  attr_accessible :first_user_id, :second_user_id, :email_sent, :match_date
  belongs_to :first_user, :class_name => "User", :foreign_key => "first_user_id"
  belongs_to :second_user, :class_name => "User", :foreign_key => "second_user_id"
  
end
