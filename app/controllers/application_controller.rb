class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  def identify_company
    @company = current_user.company
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected
      # my custom fields are :username, :image
      def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) do |u|
          u.permit(:name, :image, :remote_image_url, :company_id, :username, :department, :position, :email, :password, :password_confirmation)
        end
        devise_parameter_sanitizer.for(:account_update) do |u|
          u.permit(:name, :image, :remote_image_url, :company_id, :username, :department, :position, :email, :password, :password_confirmation, :current_password)
        end
      end
      
      # Catch all CanCan errors and alert the user of the exception

    end
