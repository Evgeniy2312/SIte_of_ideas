class ApplicationController < ActionController::API

  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :current_password,
                                                       :role, address_attributes: [:country, :skype, :telephone]])
  end
end
