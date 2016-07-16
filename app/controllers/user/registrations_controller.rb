class User::RegistrationsController < Devise::RegistrationsController
    before_filter :configure_permitted_parameters

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up).push(:first_name, :last_name, :user_name, :avatar, :cover)
      devise_parameter_sanitizer.for(:account_update).push(:first_name, :last_name, :user_name, :avatar, :cover)
    end
    
    def after_update_path_for(resource)
      profile_path(@user.user_name)
    end

end