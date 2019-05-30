# frozen_string_literal: true

# Stub APIs, mainly the google CERT_URL
require 'webmock/rspec'

# Used for testing time
require 'active_support/core_ext/numeric/time.rb'

# Helper testing methods
require './spec/helpers'

RSpec.configure do |config|
  config.include Helpers

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
