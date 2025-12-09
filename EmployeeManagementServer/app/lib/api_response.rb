# frozen_string_literal: true

class ApiResponse
  attr_reader :success, :data, :message, :errors, :status_code
  def initialize(success:, data: nil, message: nil, errors: nil, status: nil)
    @success = success
    @data = data
    @message = message
    @errors = errors
    @status_code = status
  end

  def self.success(data: nil, message: nil, status: 200)
    new(success: true, data: data, message: message, status: status)
  end

  def self.error(errors: nil, message: "An error occurred", status: 422)
    new(success: false, errors: errors, message: message, status: status)
  end

  def to_json_payload
    {
      success: @success,
      message: @message,
      data: @data,
      errors: @errors
    }.compact
  end
end


