class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  private

  def handle_record_not_found(exception)
    render json: { message: exception.message }, status: :not_found
  end
end
