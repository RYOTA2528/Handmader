class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search, :set_host


    def after_sign_in_path_for(resource)
       case resource
       when Admin
         admin_path
       when User
          public_user_path(current_user)
       end
    end
    #  def after_sign_out_path_for(resource_or_scope)
    #   if resource_or_scope == :user
    #      root_path
    #   elsif resource_or_scope == :admin
    #   new_admin_session_path
    #   end
    #  end
  protected

   def set_search
     @search = PostItem.ransack(params[:q])
     @search_products = @search.result
   end

  def after_sign_up_path_for(resource)
    edit_public_user_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def set_host
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end
end