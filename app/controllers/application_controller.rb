class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  unless Rails.application.config.consider_all_requests_local
    rescue_from ActionController::RoutingError, with: :not_found
    rescue_from ActionController::UnknownController, with: :not_found
    rescue_from AbstractController::ActionNotFound, with: :not_found
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  protected

  def not_found
    respond_to do |format|
      format.html { render template: 'shared/errors/404', status: 404 }
      format.json { render json: exception , status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  # def user_not_authorized
  #  flash[:alert] = I18n.t(:user_not_authorized)
  #  redirect_to(request.referrer || root_path)
  # end
end
