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

    def code_source
      formatter = Rouge::Formatters::HTML.new
      lexer = Rouge::Lexers::Ruby.new
      Formatters.with_translated_html_entities(formatter.format(lexer.lex(spec.source)))
    end

    def prettified_output
      Formatters.with_translated_html_entities(formatter.prettified_output)
    end

    def rendered_output
      return formatter.rendered_output if render_raw?

      Formatters.with_translated_html_entities(formatter.rendered_output)
    end

    def render_raw?
      formatter.render_raw?
    end

    def element_id
      @element_id ||= SecureRandom.uuid
    end

    private

    attr_reader :spec

    def formatter
      @formatter ||= {
        html: Formatters::Html,
        ansi: Formatters::Ansi,
        json: Formatters::Json,
        yaml: Formatters::Yaml,
        xml: Formatters::Xml
      }.fetch(spec.format, Formatters::Ruby).new(subject: spec.subject)
    end

    def tabbed_spec
      RSpecDocumentation.template('tabbed_spec').result(binding)
    end
  end
end
