# frozen_string_literal: true

module RSpecDocumentation
  # Generates documentation from Markdown files, main entry point to documentation generator.
  class Documentation
    include Paintbrush

    def generate
      start
      require_spec_helper
      page_collection.generate
      flush unless failed?
      summary.flush
    rescue RSpecDocumentation::MissingFileError => e
      warn(paintbrush { red e.message })
      @failed = true
    end

    def failed?
      @failed || !page_collection.failures.empty?
    end

    private

    def require_spec_helper
      path = pwd.join('rspec-documentation/spec_helper.rb')
      require path if path.file?
    end

    def start
      @started_at = Time.now.utc
    end

    def summary
      @summary ||= RSpecDocumentation::Summary.new(
        page_collection: page_collection,
        pwd: pwd,
        started_at: @started_at
      )
    end

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

    def pwd
      @pwd ||= Pathname.new(Dir.pwd)
    end
  end
end
