require 'spec_helper'
require 'firebase_ruby_auth'

describe FirebaseRubyAuth do
  let(:project_id) { 'test_id' }
  let(:key) { OpenSSL::PKey::RSA.new(2048) }

  it 'returns the correct email address from a valid certificate' do
    stub_public_cert(key)
    token = create_token(key: key,
                         project_id: project_id,
                         body: { email: 'test_email' })
    email = FirebaseRubyAuth.new(project_id).retrieve_email_from_token(token)
    expect(email).to eq 'test_email'
  end
end
