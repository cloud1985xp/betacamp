class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  layout 'admin'

  private

  def authenticate_admin!
    redirect_to root_path, notice: 'you are not admin' unless current_user.admin?
  end
end
