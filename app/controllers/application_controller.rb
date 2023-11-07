class ApplicationController < ActionController::API
  include FailureHandler
  include QuotaHandler

  before_action :authenticate_user!, :register_hit, :check_user_quota
end
