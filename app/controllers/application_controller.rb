class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def default_url_options(options = {})
    if I18n.locale == I18n.default_locale
      {}
    else
      { lang: I18n.locale }
    end
  end

  protected
    def authorize_user!(role_name, community: nil)
      authenticate_user!
      unless current_user.roles.where(name: role_name, community: community).exists?
        flash.alert = I18n.t("flash.permission_denied")
        redirect_to :root
      end
    end

    def set_locale
      if params[:lang]&.empty?
        I18n.locale = I18n.default_locale
      else
        I18n.locale = params[:lang] || current_user&.language || I18n.default_locale
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
    end
end
