# frozen_string_literal: true

module RSpecDocumentation
  module Formatters
    # Produces prettified XML to from an RSpec `subject` value.
    class Xml
      def initialize(subject:)
        @subject = subject
      end

      def prettified_output
        nil
      end

      def rendered_output
        formatter = Rouge::Formatters::HTML.new
        lexer = Rouge::Lexers::XML.new
        formatter.format(lexer.lex(Nokogiri::XML.parse(subject).to_xml))
      end

      def render_raw?
        false
      end

      private

      attr_reader :subject
    end
  end
end
