require_relative "../src/scadi"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  RSpec::Matchers.define :semantically_eq do |expected|
    match do |actual|
      expected.gsub(/\s+/, "") == actual.gsub(/\s+/, "")
    end

    failure_message do |actual|
      "expected `#{expected}` to equal `#{actual}` when ignoring whitespace"
    end
  end
end
