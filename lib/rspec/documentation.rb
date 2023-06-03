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
        flush unless failed?
        RSpecDocumentation::Summary.new(page_collection: page_collection, pwd: pwd).flush

        nil
      rescue RSpecDocumentation::MissingFileError => e
        warn(paintbrush { red e.message })
      end

      def require_spec_helper
        path = pwd.join('rspec-documentation/spec_helper.rb')
        require path if path.file?
      end

      def configure(&block)
        RSpecDocumentation.configure(&block)
      end

      private

      def flush
        page_collection.flush
        stylesheet_bundle.flush
        javascript_bundle.flush
      end

      def stylesheet_bundle
        @stylesheet_bundle ||= RSpecDocumentation::StylesheetBundle.new
      end

      def javascript_bundle
        @javascript_bundle ||= RSpecDocumentation::JavascriptBundle.new
      end

      def page_paths
        @page_paths ||= pwd.join('rspec-documentation/pages').glob('**/*.md')
      end

      def page_collection
        @page_collection ||= RSpecDocumentation::PageCollection.new(page_paths: page_paths)
      end

      def failed?
        !page_collection.failures.empty?
      end

      def pwd
        @pwd ||= Pathname.new(Dir.pwd)
      end
    end
  end
end
