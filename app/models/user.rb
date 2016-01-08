class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  devise :omniauthable
  
  has_many :love_interests
  has_many :friends
  
  has_many :first_user_matches, :class_name => "Match", :foreign_key => "first_user_id"
  has_many :second_user_matches, :class_name => "Match", :foreign_key => "second_user_id"

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :facebook_id, :gender, :interested_in, :first_name, :last_name, :time_zone, :locale, :location
  # attr_accessible :title, :body
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else # Create a user with a stub password. 
      User.create!(:email => data.email, :password => Devise.friendly_token[0,20], :facebook_id=>data.id, :gender=>data.gender, :interested_in=>data.interested_in,
        :first_name=>data.first_name, :last_name=>data.last_name, :time_zone=>data.timezone, :locale=>data.locale, :location=>data.location) 
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end
  
  def name
    self.first_name + ' ' + self.last_name
  end
  
  def update_friends_list(access_token)
    graph = Koala::Facebook::API.new(access_token)
    genders = ['female','male']
    genders.each {|gender|
      fb_friends = graph.fql_query("select first_name,last_name,uid,pic_square from user where uid in (select uid1 from friend where uid2=me()) and sex='#{gender}' order by uid")
      fb_friends.each {|friend|
        continue if friend.nil?
        db_friend = self.friends.where("facebook_id = ?",friend['uid']).first
        if db_friend.nil?
          new_friend = Friend.new
          new_friend.first_name = friend['first_name']
          new_friend.last_name = friend['last_name']
          new_friend.facebook_id = friend['uid']
          new_friend.gender=gender
          new_friend.fb_pic_url =friend['pic_square']
          new_friend.user_id = self.id
          self.friends << new_friend
        else
          db_friend.fb_pic_url =friend['pic_square']
          db_friend.save!
        end
        
        #TODO, remove deleted friends from this list 
        
      }
    }
  end
end
