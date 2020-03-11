class AdminController < ApplicationController
  before_action { authorize_user! "admin" }

  def home
  end
end
