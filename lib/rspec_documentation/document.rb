# frozen_string_literal: true

module RSpecDocumentation
  # Translates a Markdown document into a structure of parsed Markdown and embedded RSpec examples.
  class Document
    attr_reader :failures, :page_tree

    def initialize(document:, page_tree:)
      @document = document
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
      # TODO: Try other methods of inferring documentation title, allow setting by configuration
      gem_spec&.name
    end

    def version
      gem_spec&.version
    end

    def header
      RSpecDocumentation.template('header').result(binding)
    end

    def footer
      RSpecDocumentation.template('footer').result(binding)
    end

    private

    attr_reader :document

    def parsed_document
      @parsed_document ||= ParsedDocument.new(document)
    end

    def gem_spec
      @gem_spec ||= Gem::Specification.load(Pathname.new(Dir.pwd).glob('*.gemspec').first.to_s)
    end
  end
end
