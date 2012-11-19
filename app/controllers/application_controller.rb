class ApplicationController < ActionController::Base
  
  layout :layout_by_resource
  protect_from_forgery
  before_filter :set_locale

private
  
  def set_locale
    I18n.locale = (current_user.locale if current_user) || session[:locale] || I18n.default_locale
  end

protected

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

end


 
  
  




