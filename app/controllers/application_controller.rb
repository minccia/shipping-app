class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end    

    def require_admin
      unless current_user && current_user.role == 'admin'
        flash.notice = t('no_access_granted')
        return redirect_to root_path
      end        
    end
end
