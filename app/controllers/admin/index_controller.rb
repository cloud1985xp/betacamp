class Admin::IndexController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  def index
  end

  private

  def authenticate_admin!
    redirect_to root_path, notice: 'you are not admin' unless current_user.admin?
  end
end
