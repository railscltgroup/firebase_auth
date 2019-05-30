# frozen_string_literal: true

module Helpers
  def create_token(body: {}, key: nil, project_id: nil)
    jwk = JWT::JWK.new(key)
    payload = {
      aud: project_id,
      auth_time: 1.day.ago.to_i,
      exp: 1.day.from_now.to_i,
      iat: 1.day.ago.to_i,
      iss: "https://securetoken.google.com/#{project_id}",
      sub: '1'
    }.merge(body)
    headers = { kid: 'test_key' }
    JWT.encode(payload, jwk.keypair, 'RS256', headers)
  end

  def stub_public_cert(rsa_key)
    cert = OpenSSL::X509::Certificate.new
    cert.public_key = rsa_key.public_key
    cert.not_before = Time.now
    cert.not_after = cert.not_before + 2 * 365 * 24 * 60 * 60
    cert.sign(rsa_key, OpenSSL::Digest::SHA256.new)

    stub_request(:any, FirebaseRubyAuth::CERT_URL).to_return(
      headers: { 'cache-control' => "max-age=#{30.minutes.to_i}" },
      body: { "test_key": cert.to_pem }.to_json
    )
    cert
  end
end
