# https://github.com/jwt/ruby-jwt
require 'jwt'

# https://github.com/typhoeus/typhoeus
require 'typhoeus'

class FirebaseRubyAuth
  # This url is from the Google instructions:
  # https://firebase.google.com/docs/auth/admin/verify-id-tokens
  # This is were you can find the Google Public Key
  CERT_URL = 'https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com'.freeze

  def initialize(firebase_project_id)
    @firebase_project_id = firebase_project_id
    fetch_google_public_key
  end

  # token would be a user's ID token
  # https://firebase.google.com/docs/auth/admin/verify-id-tokens
  # This will either return a user's email address, or nil
  def retrieve_email_from_token(token)
    fetch_google_public_key if @expires < Time.now
    return if @keys.empty?
    token_values = decode_token(token)
    token_values['email'] if valid?(token_values)
  end

  private def decode_token(token)
    begin
      JWT.decode(token, nil, true, options).first
    rescue JWT::JWKError
      {}
    rescue JWT::DecodeError
      {}
    end
  end

  private def fetch_google_public_key
    # This requires the Typhoeus gem: https://github.com/typhoeus/typhoeus
    request = Typhoeus.get(CERT_URL)
    generate_keys(request)
    set_key_expiry(request)
  end

  private def generate_keys(request)
    @keys = {
      keys: (JSON.parse request.body).map do |key, value|
        JWT::JWK.new(OpenSSL::X509::Certificate.new(value).public_key).
        export.
        merge(kid: key)
      end
    }
  rescue JSON::ParserError
    @keys = {}
  end

  private def options
    {
      algorithms: ['RS256'],

      aud: @firebase_project_id,
      verify_aud: true,

      verify_iat: true,

      iss: "https://securetoken.google.com/#{@firebase_project_id}",
      verify_iss: true,

      jwks: @keys
    }
  end

  private def set_key_expiry(request)
    @expires = Time.new(request.
      headers['cache-control'].
      split(', ').
      select { |s| s.include?('max-age') }[0].
      split('max-age=')[1].
      to_i)
  end

  private def valid?(token_values)
    token_values['sub'].present? &&
    token_values['auth_time'].present? &&
    token_values['auth_time'].to_i < Time.now.utc.to_i
  end
end
