class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :require_login
  before_action :show_full_nav_bar
  
  def not_authenticated
    redirect_to login_url
  end
  
  def show_full_nav_bar
    @show_full_nav_bar = true
  end
end
