class ApplicationController < ActionController::API
  #devise
  before_action :configure_permitted_parameters, if: :devise_controller?
  #doorkeeper
  before_action :doorkeeper_authorize!
  #respond_to: json

  #  protect_from_forgery prepend: true
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_unprocessable_entity_response(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def filter_by_update_date(lastUpdateDate)
    
  end

  def filter_by_update_date(lastUpdateDate)
    
  end

  # Doorkeeper methods
  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
