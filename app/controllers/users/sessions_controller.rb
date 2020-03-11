class Users::SessionsController < Devise::SessionsController
  after_action :custom_sign_in_flash, only: %i( create )
  after_action :custom_sign_out_flash, only: %i( destroy )


  private
    def custom_sign_out_flash
      flash.notice = I18n.t('flash.goodbye')
    end

    def custom_sign_in_flash
        flash.notice = I18n.t('flash.welcome', name: current_user.first_name)
    end
end
