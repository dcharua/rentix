class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  layout :layout

  private

  def layout
    # only turn it off for login pages:
    is_a?(Devise::SessionsController) ||  is_a?(Devise::RegistrationsController)? false : "application"

  end
end
