class ApplicationController < ActionController::Base
  # before_action :set_timezone
  
  before_action :configure_sign_up_params, if: :devise_controller?
  before_action :configure_account_update_params, if: :devise_controller?

  protected
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :address])
    end
    
    # def set_timezone
    #   if cookies[:time_zone].present?
    #     Time.zone = cookies[:time_zone]
    #   end
    # end
end
