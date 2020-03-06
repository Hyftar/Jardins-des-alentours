class MarketMailer < ApplicationMailer
  def market_disponibility_update_email
    @market = params[:market]
    @market_notifications = params[:market_notifications]
    @market_notifications.each do |notification|
      I18n.with_locale(notification.language) do
        mail(to: notification.email, subject: I18n.t('mailer.subject_update_order'))
      end
  end
end
