class ApplicationController < ActionController::Base
  def current_day
    Date.today.strftime('%A').downcase
  end
  helper_method :current_day
end
