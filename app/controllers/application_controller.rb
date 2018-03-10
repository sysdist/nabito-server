class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(user)
    user_url(user)
  end

  def default_url_options(options = {})
   { locale: I18n.locale }.merge options
  end

  def set_user_language
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def set_locale
    [params[:locale], cookies[:locale], extract_locale, I18n.default_locale].each do |l|
      if l && I18n.available_locales.index(l.to_sym)
        I18n.locale = l
        break
      end
    end
    cookies[:locale] = params[:locale] if params[:locale]
  end

  def extract_locale
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first if request.env['HTTP_ACCEPT_LANGUAGE']
  end
  
  def user_admin
    if !current_user.is_admin
      redirect_to root_path, :alert => "You are not administrator, access denied."
      return false
    end
    return true
  end
    
  def user_approved
    if !current_user.is_approved
      redirect_to root_path, :alert => "Your user account is not approved yet, access denied."
      return false
    end
    return true
  end
  
  def correct_user(user)
    return true if user.is_admin
    return true if user == current_user
    return false
  end  
  
  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end
    
    def after_sign_in_path_for(resource)
      sign_in_url = new_user_session_url
      if request.referer == sign_in_url
        super
      else
        stored_location_for(resource) || request.referer || root_path
      end
    end

end
