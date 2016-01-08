class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
    profile_friends_path(current_user.id)
  end
  
  def after_sign_out_path_for(resource_or_scope)
    "https://www.facebook.com/logout.php?next=#{root_url}&access_token=#{session[:access_token]}"
  end
  
  private
  def render_403(message="Unauthorized access")
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false }
      format.json { render :json => message, :status => 403 }
    end
  end
  
  def render_422(message="Unauthorized access")
    respond_to do |format|
      format.json { render :json => "Unprocessable Entity", :status => 422 }
    end
  end
end
