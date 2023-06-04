# frozen_string_literal: true

require_relative 'documentation/version'
require_relative '../rspec_documentation'
load File.expand_path(File.join(__dir__, '../tasks/rspec/documentation/generate.rake'))

module RSpec
  # Extension for RSpec, locates RSpec examples found in a Markdown file and executes them,
  # replacing their output into a tree of Markdown files.
  module Documentation
    class Error < StandardError; end

    class << self
      include Paintbrush

      def generate_documentation
        RSpecDocumentation::Documentation.new.tap(&:generate)
      end

      def require_spec_helper
        path = pwd.join('rspec-documentation/spec_helper.rb')
        require path if path.file?
      end

      def configure(&block)
        RSpecDocumentation.configure(&block)
        return if RSpecDocumentation.configuration.context_defined?

        # Ensure `__rspec_documentation` shared context is always defined.
        RSpecDocumentation.configuration.context {} # rubocop:disable Lint/EmptyBlock
      end
    end
  end
end
