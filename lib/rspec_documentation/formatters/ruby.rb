# frozen_string_literal: true

module RSpecDocumentation
  module Formatters
    # Default formatter for all RSpec examples. Used by all examples to generate the "Spec" tab
    # content, i.e. the original source of the example code.
    class Ruby
      def initialize(subject:)
        @subject = subject
      end

      def prettified_output
        nil
      end

      def rendered_output
        formatter = Rouge::Formatters::HTML.new
        lexer = Rouge::Lexers::Ruby.new
        io = StringIO.new
        PP.pp(subject, io)
        formatter.format(lexer.lex(io.string))
      end

      def render_raw?
        false
      end

      private

      attr_reader :subject
    end
  end
end
