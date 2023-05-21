# frozen_string_literal: true

module RSpecDocumentation
  module RSpec
    # Stores information about a failed RSpec example. Thin wrapper around `RSpec::Failure`.
    class Failure
      def initialize(cause:, spec:)
        @cause = cause
        @spec = spec
      end

      def message
        "\n#{formatted_header}\n\n#{formatted_source}\n#{formatted_cause}\n\n"
      end

      private

      attr_reader :cause, :spec

      def formatted_header
        "\e[1;37m#{indented('Failure in example')}:\e[0m"
      end

      def formatted_source
        "\e[1;34m#{indented(spec.source)}\e[0m"
      end

      def formatted_cause
        "\e[31m#{indented(cause.message)}\e[0m"
      end

      def indented(text)
        text.split("\n").map { |line| "    #{line}" }.join("\n")
      end
    end
  end
end
