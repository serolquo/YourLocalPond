class LoveInterest < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :user_id, :facebook_id
  
  belongs_to :user
end
