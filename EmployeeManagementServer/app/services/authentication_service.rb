class AuthenticationService
  Response = Struct.new(:success?, :data, :errors)
  def login(username, password)
    user = User.find_by(username: username)
    if user&.authenticate(password)
         tokens = JwtService.generate_tokens(user)
         Response.new(success: true, data: tokens, errors: [])
    end
  end
end
