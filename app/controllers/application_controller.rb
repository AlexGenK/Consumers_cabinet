class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!


  protected

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "У вас нет прав на осуществление этой операции"
    redirect_back fallback_location: root_path
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
  end
end
