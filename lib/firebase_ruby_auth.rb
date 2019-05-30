# frozen_string_literal: true

# https://github.com/jwt/ruby-jwt
require 'jwt'

require 'google_public_cert'

# Interacts with data from Firebase
class FirebaseRubyAuth
  def initialize(firebase_project_id)
    @firebase_project_id = firebase_project_id
    @public_cert = GooglePublicCert.new
  end

  # token would be a user's ID token
  # https://firebase.google.com/docs/auth/admin/verify-id-tokens
  # This will either return a hash with user data, or an empty hash
  def decode_token(token)
    return {} if @public_cert.keys.empty?

    token_values = begin
                     JWT.decode(token, nil, true, options).first
                   rescue JWT::JWKError
                     {}
                   rescue JWT::DecodeError
                     {}
                   end
    valid?(token_values) ? token_values : {}
  end

  private def options
    {
      algorithms: ['RS256'],

      aud: @firebase_project_id,
      verify_aud: true,

      verify_iat: true,

      iss: "https://securetoken.google.com/#{@firebase_project_id}",
      verify_iss: true,

      jwks: @public_cert.keys
    }
  end

  private def valid?(token_values)
    token_values['sub'].present? &&
    token_values['auth_time'].present? &&
    token_values['auth_time'].to_i < Time.now.utc.to_i
  end
end
