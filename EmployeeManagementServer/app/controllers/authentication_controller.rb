class AuthenticationController < ActionController::API
  def login
    @user = User.find_by(username: params[:username])

    if @user&.authenticate(params[:password])
      token = JwtService.encode(user_id: @user.id)
      render json: { token: token, username: @user.username }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def register

  end


end
