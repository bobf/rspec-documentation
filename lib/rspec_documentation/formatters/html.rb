# frozen_string_literal: true

module RSpecDocumentation
  module Formatters
    # Beautifies HTML received from a `subject`, renders the raw subject to be inserted directly
    # into the output document.
    class Html
      def initialize(subject:)
        @subject = subject
      end

      def prettified_output
        formatter = Rouge::Formatters::HTML.new
        lexer = Rouge::Lexers::HTML.new
        formatter.format(lexer.lex(HtmlBeautifier.beautify(subject)))
      end

      def rendered_output
        subject
      end

      def render_raw?
        true
      end

      private

      attr_reader :subject
    end
  end
end
