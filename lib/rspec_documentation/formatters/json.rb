# frozen_string_literal: true

module RSpecDocumentation
  module Formatters
    # Produces prettified JSON to from an RSpec `subject` value.
    class Json
      def initialize(subject:)
        @subject = subject
      end

      def prettified_output
        nil
      end

      def rendered_output
        formatter = Rouge::Formatters::HTML.new
        lexer = Rouge::Lexers::JSON.new
        formatter.format(lexer.lex(JSON.pretty_generate(JSON.parse(subject))))
      rescue JSON::ParserError => e
        raise Error, "Expected JSON for:\n#{subject}\n\nParser Error: #{e}"
      end

      def render_raw?
        false
      end

      private

      attr_reader :subject
    end
  end
end
