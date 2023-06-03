# frozen_string_literal: true

module RSpecDocumentation
  module RSpec
    # Stores information about a failed RSpec example. Thin wrapper around `RSpec::Failure`.
    class Failure
      include Paintbrush

      attr_reader :spec

      def initialize(cause:, spec:)
        @cause = cause
        @spec = spec
      end

      def message
        "\n#{formatted_header}\n\n#{formatted_source}\n\n#{formatted_cause}\n\n"
      end

      private

      attr_reader :cause

      def formatted_header
        paintbrush { cyan indented("# #{path}:#{spec.location}") }
      end

      def path
        spec.path.relative_path_from(Pathname.new(Dir.pwd))
      end

      def formatted_source
        paintbrush { white indented(spec.source) }
      end

      def formatted_cause
        paintbrush { red indented(cause.message) }
      end

      def indented(text)
        text.split("\n").map { |line| "    #{line}" }.join("\n")
      end
    end
  end
end
