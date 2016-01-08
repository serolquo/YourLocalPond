class GeneralMailer < ActionMailer::Base
  default from: "matchmaker@yourlocalpond.com"
  
  def its_a_match(match)
    @user1 = match.first_user
    @user1_pic_url = Friend.where(:facebook_id => @user1.facebook_id).first.fb_pic_url
    @user2 = match.second_user
    @user2_pic_url = Friend.where(:facebook_id => @user2.facebook_id).first.fb_pic_url
    
    to = "#{@user1.name} <#{@user1.email}>, #{@user2.name} <#{@user2.email}>"
    mail(:to => to, :subject => "YourLocalPond: It's a match!")
  end
  
  def contact_us_form(form)
    @name = form[:name]
    @email = form[:email]
    @message = form[:message]
    
    mail(:to=>'admin@hereyak.com',:subject => 'hereYAK Contact Us Form')
  end
end
