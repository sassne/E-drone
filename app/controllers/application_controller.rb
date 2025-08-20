class ApplicationController < ActionController::Base
  include Pundit

  before_action :set_locale

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Redirige vers la page de connexion devise après déconnexion
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  # Redirige Devise vers /login si non authentifié
  def after_sign_in_path_for(resource)
    dashboard_path
  end

  private
  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
