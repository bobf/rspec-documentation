# frozen_string_literal: true

require 'rspec/documentation'
require 'rspec/file_fixtures'
require 'rspec/its'
require 'devpack'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  RSpec.shared_context('__rspec_documentation') {} # rubocop:disable Lint/EmptyBlock, RSpec/ContextWording
end
