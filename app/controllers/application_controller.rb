class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :save_visitor

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
      if params[:lang]&.present?
        I18n.locale = params[:lang]
      else
        I18n.locale = current_user&.language || I18n.default_locale
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :language])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :language])
    end


    # Enregistre l'addresse IP de l'utilisateur qui se connecte et tente de deviner sa position géographique
    def save_visitor
      return if user_signed_in?

      ip = request.remote_ip
      @visitor = Visitor.find_by(IP: ip)
      if @visitor.nil?
        @visitor = Visitor.create(IP: ip)
        results = Geocoder.search(@visitor.IP)
        @visitor_location = VisitorLocation.create(longitude: results.first.coordinates.second,
          latitude: results.first.coordinates.first,
          visitor: @visitor)
      else
        @visitor.request_count += 1
        @visitor.save
      end
    end
end
