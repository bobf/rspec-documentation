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
        "\n#{formatted_header}\n\n#{formatted_source}\n\n#{formatted_cause}\n\n#{formatted_backtrace}\n\n"
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
        paintbrush { red indented(without_anonymous_group_text(cause.message)) }
      end

      def formatted_backtrace
        cause.backtrace
             &.take_while { |line| RSpecDocumentation.configuration.full_backtrace || line.start_with?(Dir.pwd) }
             &.map { |line| paintbrush { red "    #{line.sub("#{Dir.pwd}/", '')}" } }
             &.join("\n")
      end

      def indented(text)
        text.split("\n").map { |line| "    #{line}" }.join("\n")
      end

      # If an error occurs outside of a test, RSpec will provide an error to the Reporter
      # referring to an anonymous group due to the way specs are evaluated. This does not help
      # with debugging so we remove it. TODO: Find a better way ?
      def without_anonymous_group_text(text)
        text&.gsub(/ for #<RSpec::ExampleGroups::Anonymous.*$/, '')
      end
    end
  end
end
