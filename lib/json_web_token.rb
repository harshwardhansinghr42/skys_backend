# frozen_string_literal: true

# JSON Web token
class JsonWebToken
  def self.generate_token(user_id)
    return unless user_id

    encode(payload(user_id))
  end

  def self.payload(user_id)
    {
      user_id: user_id,
      token_generation_time: Time.now
    }
  end

  def self.encode(payload)
    "Bearer #{JWT.encode(payload, Rails.application.secrets.secret_key_base)}"
  end

  def self.decode(request_header_auth)
    token = bearer_token(request_header_auth)
    HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.secret_key_base)[0])
  rescue StandardError
    nil
  end

  def self.bearer_token(request_header_auth)
    pattern = /^Bearer /
    header = request_header_auth
    header.gsub(pattern, '') if header&.match(pattern)
  end
end
