module FailureHandler
  extend ActiveSupport::Concern

  def render_400(message)
    render json: {
      error: message
    }, status: :bad_request
  end
end
