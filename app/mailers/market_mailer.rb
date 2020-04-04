class MarketMailer < ApplicationMailer
  # Used to send emails informing the users of a change in a produce's disponibility
  def market_disponibility_update_email
    @market = params[:market]
    market_notification = params[:market_notification]
    # Verify if the email address is banned
    if EmailBan.where(:email => market_notification.email).where('banned_until > ?', DateTime.now).blank?
      I18n.with_locale(market_notification.language) do
        mail(from: I18n.t("mailer.default_from"), to: market_notification.email, subject: I18n.t("mailer.subject_update_order"))
      end
    end
  end

  # Send an email to the gardener informing of an intent to buy
  def market_inquiry_email
    @garden = params[:garden]
    @message = params[:message]
    @email = params[:email]
    @varieties = params[:varieties]
    # Verify if the email address is banned
    if EmailBan.where(:email => params[:email]).where('banned_until > ?', DateTime.now).blank?
      I18n.with_locale(@garden.user.language) do
        mail(from: @email, to: @garden.user.email, subject: I18n.t("mailer.market_inquiry_email.subject"))
      end
    end
  end
end
