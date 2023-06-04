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
      def generate_documentation
        RSpecDocumentation::Documentation.new.tap(&:generate)
      end

      def configure(&block)
        RSpecDocumentation.configure(&block)
      end
    end
  end
end
