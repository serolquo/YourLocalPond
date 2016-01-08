class ProfileController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user
  
  def friends
    #@me = @graph.get_picture("me",:type=>:square)   
    if session[:updated_friends_list].nil?
      current_user.update_friends_list(session[:access_token])
      session[:updated_friends_list] = true
    end
    
    if (params['gender'].blank?) 
      @gender = current_user.gender == 'female' ? 'male' : 'female'
    else
      @gender = params['gender'] == 'male' ? 'male' : 'female'
    end
    
    if params['page'].blank?
      @page = 0
    else
      @page = params['page'].to_i
    end
    
    @max_per_page = 75
    @friends = current_user.friends.where('gender = ?',@gender).limit(@max_per_page).offset(@max_per_page*@page).order("first_name")
    
    @love_interests_facebook_ids = []
    current_user.love_interests.each { |love_interest|
      @love_interests_facebook_ids << love_interest.love_facebook_id
    }
  end
  
  def interested_in
    begin
    
      if (current_user.love_interests.count >= 5)
        @message = t(:error422_too_many_interests)
        respond_to do |format|
          format.js
        end
        return
      end
      params[:uid] = params[:uid].to_i
      
      target_user = User.where(:facebook_id=>params[:uid]).first
      if target_user != nil
        reverse_love = target_user.love_interests.where(:love_facebook_id=>current_user.facebook_id).first
        if reverse_love != nil
          m = Match.where("(first_user_id = ? and second_user_id = ?) or (first_user_id = ? and second_user_id = ?)",target_user.id,current_user.id,current_user.id,target_user.id).first
          if (m != nil and m.email_sent == 'y')
            @message = t(:error_previously_matched)
            respond_to do |format|
              format.js
            end
            return
          end
          if (m == nil) 
            match = Match.new
            match.first_user_id = target_user.id
            match.second_user_id = current_user.id
            match.email_sent = 'n'
            match.match_date = DateTime.now
            match.save!
          end
        end
      end
      love_interest = LoveInterest.new
      love_interest.user_id = current_user.id
      love_interest.love_facebook_id = params[:uid]
      love_interest.save!
      
      respond_to do |format|
        format.js
      end
    rescue Exception => e
      logger.error e.message
      e.backtrace.each { |line| logger.error line }
      respond_to do |format|
        @message = t(:error_generic)
        format.js
      end  
    end
  end
  
  def not_interested_in
    begin
      params[:uid] = params[:uid].to_i
      
      target_user = User.where(:facebook_id=>params[:uid]).first
      if target_user != nil
        m = Match.where("(first_user_id = ? and second_user_id = ?) or (first_user_id = ? and second_user_id = ?)",target_user.id,current_user.id,current_user.id,target_user.id).first
        m.destroy if (m != nil and m.email_sent=='n')
      end
      
      current_user.love_interests.where(:love_facebook_id=>params[:uid]).destroy_all
      respond_to do |format|
        format.js
      end
    rescue Exception => e
      logger.error e.message
      e.backtrace.each { |line| logger.error line }
      respond_to do |format|
        @message = t(:error_generic)
        format.js
      end  
    end
  end
  
  private
  def authorize_user
    if params[:profile_id].to_i != current_user.id
      render_403
    end
  end
  
  def render_422
    
    
  end
end
