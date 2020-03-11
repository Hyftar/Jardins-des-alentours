class RolesController < ApplicationController
  before_action { authorize_user! "admin" }
  before_action :get_users, only: %i( index )
  before_action :find_users, only: %i( search )
  before_action :get_user_and_role, only: %i( set_role )

  def index
  end

  def set_role
    if @user == current_user
      render status: :bad_request,
        json: {
          message: I18n.t('roles.error')
        }
      return
    end

    if params[:status] == 'true'
      @user.roles << @role
    else
      @user.roles.delete(@role)
    end

    render status: :ok,
      json: {
        message: I18n.t(
          'roles.change_successful',
          name: "#{@user.first_name} #{@user.last_name}"
        )
      }
  end

  def search
    render partial: 'users_search_results',
      layout: false,
      locals: { users: @users, roles: @roles }
  end

  private
    def get_users
      find_users if params.key? :search
    end

    def get_user_and_role
      @role = Role.find(params[:role_id])
      @user = User.find(params[:user_id])
    end

    def find_users
      @roles = Role.all
      @users = User
        .where(
          "LOWER(CONCAT(first_name, ' ', last_name)) LIKE LOWER(:search)",
          search: "%#{params[:search]}%"
        )
        .order(score: :desc)
        .includes(roles: [{ community: :produce }])
        .paginate(page: params[:page], per_page: 1)
    end
end
