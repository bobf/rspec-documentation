# frozen_string_literal: true

module RSpecDocumentation
  # A parsed Markdown file, provides matched RSpec examples from the document and their location.
  class ParsedDocument
    attr_reader :failures

    include Paintbrush

    def initialize(document, path:)
      @document = Kramdown::Document.new(
        document,
        toc_levels: 2...6,
        input: 'GFM',
        syntax_highlighter: 'rouge',
        auto_ids: true
      )
      @path = path
      @failures = []
    end

    def html
      document.to_html_rspec_documentation
    end

    def execute_and_substitute_examples!
      print_empty if specs.empty?
      specs.each do |spec|
        spec.run
        process_outcome(spec)
        break if RSpecDocumentation.configuration.fail_fast && !failures.empty?
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

    def process_outcome(spec)
      if spec.failure.nil?
        print_success(spec)
        spec.parent.children[spec.index] = spec_element(spec)
      else
        print_failure(spec)
        failures << spec.failure
      end
    end

    def relative_path
      path.relative_path_from(Util.base_dir)
    end

    def report_error(spec)
      $stderr.write(spec.failure.message)
    end

    def print_empty
      warn(paintbrush { cyan "    #{relative_path}" })
    end

    def print_success(spec)
      warn(paintbrush { green "    #{relative_path}:#{spec.location}" })
    end

    def print_failure(spec)
      warn(paintbrush { red "    #{relative_path}:#{spec.location}" })
    end
  end
end
