class CustomFailure < Devise::FailureApp
  def redirect_url
    if warden_options[:scope] == :user
      new_user_registration_path
    else
      new_user_registration_path
    end
  end

  # Redirect to root_url
  def respond
    if http_auth?
      http_auth
    else
      redirect_to root_url
    end
  end
end