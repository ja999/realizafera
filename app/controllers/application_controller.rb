class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  alias_method :h, :view_context
  helper_method :user_is_admin?

  before_filter :pass_variables_to_gon
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  private

  def authenticate_admin_user!
    if !current_user.is_admin?
      flash[:error] = 'Nie masz uprawnień, żeby tam wściubiać nos... ;)'
      redirect_to root_path
      false
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u|
      u.permit(:password, :password_confirmation, :current_password)
    }
  end

  def user_is_admin?
    current_user.is_admin?
  end

  def pass_variables_to_gon
    gon.environment = Rails.env
    gon.current_user = UserSerializer.new(current_user)
  end
end
