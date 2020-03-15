class HomeController < ApplicationController
  def index
    @geo_not_supported = I18n.t("landing_page.geo_not_supported")
    @error_location = I18n.t("landing_page.error_location")
  end
end
