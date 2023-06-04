# frozen_string_literal: true

module RSpecDocumentation
  # Executes specs from a Markdown code block and provides the outcome in the appropriate format.
  class Spec
    attr_reader :parent, :location, :index, :format, :path

    @durations = []

    class << self
      attr_accessor :subjects
      attr_accessor :durations
    end

    def initialize(spec:, format:, parent:, location:, path:, index:) # rubocop:disable Metrics/ParameterLists
      @spec = spec
      @format = format.empty? ? :plaintext : format.to_sym
      @parent = parent
      @location = location
      @path = path
      @index = index
      @failures = []
    end

    def described_object
      raise Error, "Code block did not define a subject:\n#{spec}" if subjects.empty?
      raise Error, "Cannot define more than one example per code block:\n#{spec}" if subjects.size > 1

      subjects.last
    end

    def source
      spec
    end

    def failure
      failures.first
    end

    def reporter
      @reporter ||= ::RSpec::Core::Reporter.new(::RSpec::Core::Configuration.new)
    end

    def run
      self.class.subjects = []
      RSpec.with_failure_notifier(failure_notifier) do
        succeeded = example_group.run(reporter)
        durations << reporter.examples.first.execution_result.run_time
        next if succeeded

        notify_failure(reporter.failed_examples.first.exception.all_exceptions.first)
      end
    end

    private

    attr_reader :spec, :failures

    def subjects
      self.class.subjects
    end

    def durations
      self.class.durations
    end

    def examples
      @examples ||= example_group.examples
    end

    def example_group
      # rubocop:disable Style/DocumentDynamicEvalDefinition, Security/Eval
      @example_group ||= binding.eval(
        <<-SPEC, __FILE__, __LINE__.to_i
          ::RSpec::Core::ExampleGroup.describe do
            after { RSpecDocumentation::Spec.subjects << subject }
            include_context '__rspec_documentation' do
              #{spec}
            end
          end
        SPEC
      )
      # rubocop:enable Style/DocumentDynamicEvalDefinition, Security/Eval
    end

    def notify_failure(failure)
      failures << RSpec::Failure.new(cause: failure, spec: self)
    end

    def failure_notifier
      proc { |failure| notify_failure(failure) }
    end
  end
end
