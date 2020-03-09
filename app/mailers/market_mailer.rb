class MarketMailer < ApplicationMailer
  def market_disponibility_update_email
    @market = params[:market]
    market_notification = params[:market_notification]
    I18n.with_locale(market_notification.language) do
      mail(to: market_notification.email, subject: I18n.t("mailer.subject_update_order"))
    end
  end
end
