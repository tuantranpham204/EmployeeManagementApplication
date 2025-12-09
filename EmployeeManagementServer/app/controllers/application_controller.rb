class ApplicationController < ActionController::API
  include ExceptionHandler

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header # Extract token from "Bearer <token>"

    decoded = JwtService.decode(header)

    if decoded
      @current_user = User.find(decoded[:user_id])
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end


  def succeed(data: nil, message: nil, status: :ok)
    response = ApiResponse.success(data: data, message: message, status: status)
    render json: response.to_json_payload, status: response.status_code
  end
  def error(errors: nil, message: nil, status: :unprocessable_entity)
    response = ApiResponse.error(errors: errors, message: message, status: status)
    render json: response.to_json_payload, status: response.status_code
  end

end
