# frozen_string_literal: true

require 'spec_helper'
require 'google_public_cert'

describe GooglePublicCert do
  it 'successfully decodes certificates' do
    WebMock.allow_net_connect!
    expect(GooglePublicCert.new.keys[:keys].length).to be >= 2
    WebMock.disable_net_connect!
  end

  it 'does not error when net/http fails' do
    stub_request(:any, GooglePublicCert::CERT_URL)

    expect(GooglePublicCert.new.keys).to be_empty
  end

  it 'does not error if expire time is missing' do
    stub_request(:any, GooglePublicCert::CERT_URL)
      .to_return(headers: {}, body: {}.to_json)

    expect(GooglePublicCert.new.keys[:keys]).to be_empty
  end
end
