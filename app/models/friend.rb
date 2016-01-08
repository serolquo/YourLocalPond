class Friend < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  attr_accessible :facebook_id, :gender, :first_name, :last_name
  
  def name
    self.first_name + ' ' + self.last_name
  end
end
