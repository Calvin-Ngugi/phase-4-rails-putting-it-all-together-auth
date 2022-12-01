class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :authenticate
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  private

  def authenticate
    render json: {errors: "Not Authorized"} status: :unauthorized unless session.include? :user_id
  end

  def render_unprocessable_entity_response(e)
    render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
  end
end
