# frozen_string_literal: true

require_relative 'documentation/version'
require_relative '../rspec_documentation'
load File.expand_path(File.join(__dir__, '../tasks/rspec/documentation/generate.rake'))

module RSpec
  # Extension for RSpec, locates RSpec examples found in a Markdown file and executes them,
  # replacing their output into a tree of Markdown files.
  module Documentation
    class Error < StandardError; end

    def self.generate_documentation
      require_spec_helper
      page_paths = Pathname.new(Dir.pwd).join('rspec-documentation/pages').glob('**/*.md')
      page_collection = RSpecDocumentation::PageCollection.new(page_paths: page_paths)
      page_collection.generate
      return page_collection.flush if page_collection.failures.empty?

      page_collection.failures.each do |failure|
        $stderr.write(failure.message)
      end
    end

    def self.require_spec_helper
      path = Pathname.new(Dir.pwd).join('rspec-documentation/spec_helper.rb')
      require path if path.file?
    end

    def self.configure(&block)
      RSpecDocumentation.configure(&block)
    end
  end
end
