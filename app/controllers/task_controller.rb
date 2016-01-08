class TaskController < ApplicationController
  def send_matches
    if request.env['REMOTE_ADDR'].include?('127.0.0.1') == false
      @status = 'not running'
      return
    end
    matches = Match.where(:email_sent=>'n')
    matches.each {|match|
      #if ((Time.now - match.match_date.to_time)/3600).round > 24
        GeneralMailer.its_a_match(match).deliver
        match.email_sent = 'y'
        match.save!  
      #end
      
    }
    @status = 'success'
 
  end
end
