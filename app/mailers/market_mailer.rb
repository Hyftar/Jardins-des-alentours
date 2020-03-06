class MarketMailer < ApplicationMailer
  def market_disponibility_update_email
    @market = params[:market]
    @market_notifications = params[:market_notifications]
    @emails = []
    @market_notifications.each do |notification|
      @emails.push(notification.email)
    end
    mail(to: "jardinsdesalentours@gmail.com", bcc: @emails, subject: I18n.t('mailer.subject_update_order'))
  end
end
