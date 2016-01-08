class HomeController < ApplicationController
  def index
    #redirect_to profile_friends_path(current_user.id)
  end
  
  def contact
    render 'send_contact_form'
  end
  
  def send_contact_form
    if params[:message].blank?
      @message = "Please do not leave the message field blank."
      return
    end
    
    GeneralMailer.contact_us_form(params).deliver
    @message_sent = true
      
  end
end
