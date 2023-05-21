# frozen_string_literal: true

module RSpecDocumentation
  # Receives a spec manifest and generates a `Kramdown::Document` contaning an HTML node with a
  # tabbed view displaying the example's code, its output and, if format is `:html`, the rendered
  # HTML of the output. Injected into the parsed `Kramdown::Document` for the root Markdown file,
  # replacing the code block it was produced from.
  class HtmlElement
    def initialize(spec:)
      @spec = spec
    end

    def element
      Kramdown::Document.new(tabbed_spec, input: 'html').root
    end

    def html_source
      return nil unless spec.format == :html

      formatter = Rouge::Formatters::HTML.new
      lexer = Rouge::Lexers::HTML.new
      formatter.format(lexer.lex(spec.described_object))
    end

    def code_source
      formatted_ruby(spec.source)
    end

    def rendered_result
      return spec.described_object if spec.format == :html

      formatted_ruby(spec.described_object.inspect)
    end

    def element_id
      @element_id ||= SecureRandom.uuid
    end

    private

    attr_reader :spec

    def tabbed_spec
      RSpecDocumentation.template('tabbed_spec').result(binding)
    end

    def formatted_ruby(code)
      formatter = Rouge::Formatters::HTML.new
      lexer = Rouge::Lexers::Ruby.new
      formatter.format(lexer.lex(code))
    end
  end
end
