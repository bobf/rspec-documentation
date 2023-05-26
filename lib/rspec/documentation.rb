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
        require_spec_helper
        page_collection.generate
        page_collection.flush unless failed?
        print_summary
        nil
      end

      def require_spec_helper
        path = Pathname.new(Dir.pwd).join('rspec-documentation/spec_helper.rb')
        require path if path.file?
      end

      def configure(&block)
        RSpecDocumentation.configure(&block)
      end

      private

      def print_success_summary
        warn(paintbrush { green("\n  Created #{blue(page_paths.size)} pages.\n") })
        warn(paintbrush { cyan("  View your documentation here: #{white(bundle_index_path)}\n") })
      end

      def print_failure_summary
        page_collection.failures.each do |failure|
          $stderr.write(failure.message)
        end
      end

      def bundle_index_path
        page_collection.bundle_path.glob('*.html').first
      end

      def page_paths
        @page_paths ||= Pathname.new(Dir.pwd).join('rspec-documentation/pages').glob('**/*.md')
      end

      def page_collection
        @page_collection ||= RSpecDocumentation::PageCollection.new(page_paths: page_paths)
      end

      def failed?
        !page_collection.failures.empty?
      end

      def print_summary
        if failed?
          print_failure_summary
        else
          print_success_summary
        end

        nil
      end
    end
  end
end
