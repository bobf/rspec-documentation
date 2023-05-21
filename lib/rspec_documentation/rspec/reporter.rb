# frozen_string_literal: true

module RSpecDocumentation
  module RSpec
    # RSpec reporter, compliant with RSpec::Core::Reporter. Stores outcomes of specs.
    class Reporter
      attr_reader :passed_examples, :failed_examples

      def initialize
        @passed_examples = []
        @failed_examples = []
      end

      def described_object
        raise Error, 'Code block did not contain an example.' if passed_examples.empty? && failed_examples.empty?

        passed_examples&.first&.metadata&.fetch(:described_object)
      end

      def report(*_); end

      def finish(*_); end

      def example_passed(example)
        raise Error, 'Cannot define more than one example per code block.' if passed_examples.size >= 1

        passed_examples << example
      end

      def example_group_started(*_); end

      def example_group_finished(*_); end

      def example_started(*_); end

      def example_finished(*_); end

      def example_failed(example)
        failed_examples << example
      end

      def fail_fast_limit_met?(*_); end
    end
  end
end
