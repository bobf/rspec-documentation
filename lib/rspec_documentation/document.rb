# frozen_string_literal: true

module RSpecDocumentation
  # Translates a Markdown document into a structure of parsed Markdown and embedded RSpec examples.
  class Document
    attr_reader :failures, :page_tree

    def initialize(document:, path:, page_tree:)
      @document = document
      @path = path
      @page_tree = page_tree
      @failures = []
    end

    def specs
      @specs ||= parsed_document.specs
    end

    def render
      parsed_document.execute_and_substitute_examples!
      if parsed_document.failures.empty?
        RSpecDocumentation.template('layout').result(binding)
      else
        failures.concat(parsed_document.failures)
        nil
      end
    end

    def html
      parsed_document.html
    end

    def title
      gem_spec&.name || 'Documentation'
    end

    def version
      gem_spec&.version
    end

    def homepage
      gem_spec&.homepage
    end

    def header
      RSpecDocumentation.template('header').result(binding)
    end

    def footer
      RSpecDocumentation.template('footer').result(binding)
    end

    def stylesheet_bundle_href
      Util.assets_root.join('bundle.css')
    end

    def javascript_bundle_src
      Util.assets_root.join('bundle.js')
    end

    private

    attr_reader :document, :path

    def parsed_document
      @parsed_document ||= ParsedDocument.new(with_table_of_contents(document), path: path)
    end

    def gem_spec
      @gem_spec ||= Gem::Specification.load(Pathname.new(Dir.pwd).glob('*.gemspec').first.to_s)
    end

    def with_table_of_contents(markdown)
      return markdown unless RSpecDocumentation.configuration.table_of_contents

      ['* TOC', '{:toc}', markdown].join("\n")
    end
  end
end
