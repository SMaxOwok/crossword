class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  layout :layout_by_resource

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def authority_forbidden(error)
    Authority.logger.warn(error.message)
    redirect_to request.referrer.presence || root_path, alert: 'You are not authorized to complete that action.'
  end

  def current_day
    Date.today.strftime('%A').downcase
  end
  helper_method :current_day

  private

  def layout_by_resource
    return 'devise' if devise_controller?

    'application'
  end
end
