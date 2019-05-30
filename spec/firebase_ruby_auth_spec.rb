require 'spec_helper'
require 'firebase_ruby_auth'

describe FirebaseRubyAuth do
  let(:project_id) { 'test_id' }
  let(:key) { OpenSSL::PKey::RSA.new(2048) }

  before { stub_public_cert(key) }

  context 'when validating a token payload' do
    it 'retrieves an email address from a valid certificate' do
      token = create_token(key: key, project_id: project_id,
                           body: { email: 'test_email' })
      email = FirebaseRubyAuth.new(project_id).retrieve_email_from_token(token)
      expect(email).to eq 'test_email'
    end

    it 'does not retrieve email when project_id does not match' do
      token = create_token(key: key, project_id: project_id,
                           body: { email: 'test_email' })
      email = FirebaseRubyAuth.new('bad_id').retrieve_email_from_token(token)
      expect(email).to eq nil
    end

    it 'does not retrieve email when expiration date has passed' do
      token = create_token(key: key, project_id: project_id,
                           body: { exp: 1.day.ago.to_i, email: 'test_email' })
      email = FirebaseRubyAuth.new(project_id).retrieve_email_from_token(token)
      expect(email).to eq nil
    end

    it 'does not retrieve email when iat date is in the future' do
      token = create_token(key: key, project_id: project_id,
                           body: { iat: 1.week.from_now.to_i, email: 'test_email' })
      email = FirebaseRubyAuth.new(project_id).retrieve_email_from_token(token)
      expect(email).to eq nil
    end
  end
end
