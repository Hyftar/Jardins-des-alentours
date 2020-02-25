class UsersController < ApplicationController
  def list
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @roles = Roles.all
  end

  def delete
  end
end
