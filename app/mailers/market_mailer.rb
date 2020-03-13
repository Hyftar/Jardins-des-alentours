class MarketMailer < ApplicationMailer
  def market_disponibility_update_email
    @market = params[:market]
    market_notification = params[:market_notification]
    I18n.with_locale(market_notification.language) do
      mail(from: I18n.t("mailer.default_from"), to: market_notification.email, subject: I18n.t("mailer.subject_update_order"))
    end
  end

  def market_inquiry_email
    @garden = params[:garden]
    @message = params[:message]
    @email = params[:email]
    @varieties = params[:varieties]
    I18n.with_locale(@garden.user.language) do
      mail(from: @email, to: @garden.user.email, subject: I18n.t("mailer.market_inquiry_email.subject"))
    end
  end
end
