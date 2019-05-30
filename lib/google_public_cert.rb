# frozen_string_literal: true

# https://github.com/jwt/ruby-jwt
require 'jwt'

require 'net/http'

# Fetches and decodes public certificates from google
class GooglePublicCert
  # This url is from the Google instructions,
  # https://firebase.google.com/docs/auth/admin/verify-id-tokens
  CERT_URL = 'https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com'

  def initialize
    fetch_google_public_key
  end

  def keys
    fetch_google_public_key if @expires < Time.now.utc
    @keys
  end

  private def fetch_google_public_key
    request = Net::HTTP.get_response(URI(CERT_URL))
    generate_keys(request)
    generate_key_expiry(request)
  end

  private def generate_keys(request)
    @keys = {
      keys: (JSON.parse request.body).map do |key, value|
        JWT::JWK
          .new(OpenSSL::X509::Certificate.new(value).public_key)
          .export
          .merge(kid: key)
      end
    }
  rescue JSON::ParserError
    @keys = {}
  end

  private def generate_key_expiry(request)
    headers = /max-age=\d+/.match(request.header['cache-control'].to_s).to_s
    @expires = if headers.present?
                 Time.new(headers.split('max-age=')[1].to_i).utc
               else
                 Time.now.utc
               end
  end
end
