class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_create_params, only: [:create]
  before_action :configure_update_params, only: [:update]

  protected

  def configure_create_params
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password, :first_name, :last_name)
    end
  end

  def configure_update_params
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email, :password, :first_name, :last_name, :current_password)
    end
  end
end
