module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses for specific business logic failures
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    # ----------------------------------------------------------------
    # 1. CATCH-ALL (500 Internal Server Error)
    # ----------------------------------------------------------------
    # Define this FIRST so specific errors below override it.
    rescue_from StandardError do |e|
      # Log the full error for the backend developer
      Rails.logger.error("UNHANDLED ERROR: #{e.message}")
      Rails.logger.error(e.backtrace.join("\n"))

      # Return a generic safe message to the user
      render_error(
        message: "Internal Server Error. Please contact support.",
        status: :internal_server_error # 500
      )
    end

    # ----------------------------------------------------------------
    # 2. SPECIFIC HANDLERS (Override the catch-all)
    # ----------------------------------------------------------------

    # 404 - Not Found
    rescue_from ActiveRecord::RecordNotFound do |e|
      render_error(
        message: "Resource not found",
        status: :not_found # 404
      )
    end

    # 422 - Validation Failed (e.g., user.save! fails)
    rescue_from ActiveRecord::RecordInvalid do |e|
      render_error(
        message: "Validation failed",
        errors: e.record.errors.full_messages,
        status: :unprocessable_entity # 422
      )
    end

    # 409 - Database Conflict (e.g., Duplicate email violates Unique Constraint)
    rescue_from ActiveRecord::RecordNotUnique do |e|
      render_error(
        message: "Duplicate record",
        errors: ["A record with this information already exists."],
        status: :conflict # 409
      )
    end

    # 400 - Bad Request (e.g. missing required params)
    rescue_from ActionController::ParameterMissing do |e|
      render_error(
        message: "Missing parameter",
        errors: [e.message],
        status: :bad_request # 400
      )
    end

    # 401 - Authentication Errors (JWT)
    rescue_from ExceptionHandler::AuthenticationError,
                ExceptionHandler::MissingToken,
                ExceptionHandler::InvalidToken,
                JWT::DecodeError do |e|
      render_error(
        message: "Unauthorized",
        errors: [e.message],
        status: :unauthorized # 401
      )
    end
  end
end