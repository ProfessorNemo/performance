# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  rescue_from ActionController::ParameterMissing do
    render json: { errors: 'bad request' }, status: :bad_request
  end

  def not_found
    render json: { errors: 'not found' }, status: :not_found
  end

  private

  def respond_with(object)
    if object.valid?
      render json: object
    else
      render json: { errors: object.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
