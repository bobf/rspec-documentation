# frozen_string_literal: true

module RSpecDocumentation
  # Configures the rspec-documentation gem, allows setting a context that makes values available to each example.
  class Configuration
    def initialize
      @context = Context.new
    end

    def context
      yield @context if block_given?
      @context
    end
  end
end
