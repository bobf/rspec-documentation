# frozen_string_literal: true

module RSpecDocumentation
  # Executes specs from a Markdown code block and provides the outcome in the appropriate format.
  class Spec
    attr_reader :parent, :location, :index, :format

    def initialize(spec:, format:, parent:, location:, index:)
      @spec = spec
      @format = format.empty? ? :plaintext : format.to_sym
      @parent = parent
      @location = location
      @index = index
      @failures = []
      @reporter = RSpec::Reporter.new
    end

    def described_object
      @described_object ||= reporter.described_object
    end

    def source
      spec
    end

    def failure
      failures.first
    end

    def run
      RSpec.with_failure_notifier(failure_notifier) do
        example_group.run(reporter)
      end
    end

    private

    attr_reader :spec, :failures, :reporter

    def examples
      @examples ||= example_group.examples
    end

    def example_group
      # rubocop:disable Style/DocumentDynamicEvalDefinition, Security/Eval
      @example_group ||= binding.eval(
        <<-SPEC, __FILE__, __LINE__.to_i
          RSpec::ExampleGroup.describe do
            #{spec}
          end
        SPEC
      )
      # rubocop:enable Style/DocumentDynamicEvalDefinition, Security/Eval
    end

    def failure_notifier
      proc do |failure|
        failures << RSpec::Failure.new(cause: failure, spec: self)
      end
    end
  end
end
