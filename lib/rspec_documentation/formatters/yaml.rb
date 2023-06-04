# frozen_string_literal: true

module RSpecDocumentation
  module Formatters
    # Produces prettified YAML to from an RSpec `subject` value.
    class Yaml
      def initialize(subject:)
        @subject = subject
      end

      def prettified_output
        nil
      end

      def rendered_output
        formatter = Rouge::Formatters::HTML.new
        lexer = Rouge::Lexers::YAML.new
        formatter.format(lexer.lex(YAML.safe_load(subject, permitted_classes: permitted_classes).to_yaml))
      rescue Psych::SyntaxError => e
        raise Error, "Expected YAML for:\n#{subject}\n\nSyntax Error: #{e}"
      end

      def render_raw?
        false
      end

      private

      attr_reader :subject

      def permitted_classes
        [Symbol, Date, Time, DateTime]
      end
    end
  end
end
