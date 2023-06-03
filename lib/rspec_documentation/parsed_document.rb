# frozen_string_literal: true

module RSpecDocumentation
  # A parsed Markdown file, provides matched RSpec examples from the document and their location.
  class ParsedDocument
    attr_reader :failures

    def initialize(document, path:)
      @document = Kramdown::Document.new(document, input: 'GFM', syntax_highlighter: 'rouge')
      @path = path
      @failures = []
    end

    def html
      document.to_html
    end

    def execute_and_substitute_examples!
      specs.each do |spec|
        spec.run
        break failures << spec.failure unless spec.failure.nil?

        spec.parent.children[spec.index] = spec_element(spec)
      end
    end

    def specs
      @specs ||= recursive_specs
    end

    private

    attr_reader :document, :path

    def recursive_specs(element: document.root)
      element.children.each.with_index.map do |child, index|
        next recursive_specs(element: child) unless child.children.empty?
        next nil unless rspec_codeblock?(child)

        spec_for(element: child, parent: element, index: index)
      end.flatten.compact
    end

    def rspec_codeblock?(element)
      return false unless element.type == :codeblock
      return false unless element.options.key?(:lang)

      element.options[:lang] == 'rspec' || element.options[:lang].start_with?('rspec:')
    end

    def spec_for(element:, parent:, index:)
      Spec.new(
        spec: element.value,
        format: element.options[:lang].partition(':').last,
        parent: parent,
        index: index,
        path: path,
        location: element.options[:location]
      )
    end

    def spec_element(spec)
      Kramdown::Element.new(:html_element, 'div', { location: spec.location }).tap do |element|
        element.children = HtmlElement.new(spec: spec).element.children
      end
    end

    def report_error(spec)
      $stderr.write(spec.failure.message)
    end
  end
end
