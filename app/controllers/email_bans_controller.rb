class EmailBansController < ApplicationController
  before_action { authorize_user! "admin" }

  # Email bans are verified before sending emails
  def show
    @email_ban = EmailBan.includes(:user).find(params[:id])
  end

  # A maximum of 30 items are shown per page
  def index
    @email_bans = EmailBan.order(created_at: :desc).paginate(page: params[:page], per_page: 30)
  end

  def new
  end

  def create
    if EmailBan.create!(email: email_ban_param['email'], banned_until: email_ban_param['banned_until'],
      reason: email_ban_param['reason'], user: current_user)
      redirect_to email_bans_path()
    else
      render action: "new"
    end
  end

  def edit
    @email_ban = EmailBan.includes(:user).find(params[:id])
  end

  def update
    @email_ban = EmailBan.find(params[:id])
    @email_ban.email = params['email_ban']['email']
    @email_ban.banned_until = params['email_ban']['banned_until']
    @email_ban.reason = params['email_ban']['reason']
    @email_ban.user = current_user
    if @email_ban.save
      redirect_to action: "show", id: @email_ban
    else
      render action: "edit"
    end
  end

  private
    def email_ban_param
      params.permit(:email, :banned_until, :reason, :id)
    end

end
