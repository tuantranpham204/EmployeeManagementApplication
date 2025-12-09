# frozen_string_literal: true

class JwtService
  SECRET_KEY = ENV.fetch('SYSTEM_JWT_SECRET')
  EXPIRATION_HOURS = ENV.fetch('EXPIRATION_HOURS')

  def self.encode(payload, exp = EXPIRATION_HOURS.hours.from_now)
    payload[:exp] = exp.to_i.hours.from_now.to_i
    JWT.encode(payload, SECRET_KEY)
  end
  def self.decode(token)
    decoded_token = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' })
    HashWithIndifferentAccess.new decoded_token
  rescue JWT::ExpiredSignature
    nil
  end
  def generate_tokens(user)
    {
      access_token: self.encode(user_id: user.id),
      expires_in: EXPIRATION_HOURS.hours.to_i
    }
  end
end
