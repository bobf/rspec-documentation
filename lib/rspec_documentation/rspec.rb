# frozen_string_literal: true

require_relative 'rspec/example_group'
require_relative 'rspec/reporter'
require_relative 'rspec/failure'

module RSpecDocumentation
  # Provides various classes that wrap or interface RSpec internals.
  module RSpec
    def self.with_failure_notifier(callable, &block)
      ::RSpec::Support.with_failure_notifier(callable, &block)
    end
  end
end
