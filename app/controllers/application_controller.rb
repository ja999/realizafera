class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  alias_method :h, :view_context

  before_filter :pass_variables_to_gon

  private

  def pass_variables_to_gon
    gon.environment = Rails.env
    gon.current_user = UserSerializer.new(current_user)
  end
end
