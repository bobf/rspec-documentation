# frozen_string_literal: true

module RSpecDocumentation
  # Provides a summary of the test run including details of any failures.
  class Summary
    include Paintbrush

    def initialize(page_collection:, pwd:, started_at:)
      @page_collection = page_collection
      @pwd = pwd
      @duration = Time.now.utc - started_at
    end

    def flush
      if page_collection.failures.empty?
        print_success_summary
      else
        print_failure_summary
      end

      print_duration_summary

      nil
    end

    private

    attr_reader :page_collection, :pwd, :duration

    def print_success_summary
      warn(successful_examples_summary)
      warn(paintbrush { blue("\n  Created #{green(page_collection.page_paths.size)} pages.\n") })
      warn(paintbrush { white("  View your documentation here: #{blue(Util.bundle_index_path)}\n") })
    end

    def print_failure_summary
      page_collection.failures.each do |failure|
        warn(failure.message)
      end

      warn(failure_summary)
      warn("\nFailed examples:\n\n")
      warn(failed_examples_summary)
      $stderr.puts
    end

    def print_duration_summary
      warn(duration_summary)
    end

    def failure_summary
      examples = pluralize(page_collection.examples_count, 'example')
      failures = pluralize(page_collection.failures.size, 'failure')
      paintbrush do
        red "#{page_collection.examples_count} #{examples}, #{page_collection.failures.size} #{failures}."
      end
    end

    def successful_examples_summary
      examples = pluralize(page_collection.examples_count, 'example')
      failures = pluralize(page_collection.failures.size, 'failure')
      paintbrush do
        green "\n  #{cyan page_collection.examples_count} #{examples}, " \
              "#{cyan page_collection.failures.size} #{failures}."
      end
    end

    def pluralize(count, noun)
      count.zero? || count > 1 ? "#{noun}s" : noun
    end

    def failed_examples_summary
      page_collection.failures.map(&:spec).map do |spec|
        paintbrush { red "  #{spec.path.relative_path_from(pwd)}:#{spec.location}" }
      end.join("\n")
    end

    def duration_summary
      formatted_spec_duration = format('%.2g', RSpecDocumentation::Spec.durations.sum)
      formatted_total_duration = format('%.2g', duration)
      paintbrush do
        cyan "  Total build time: #{white formatted_total_duration} seconds, " \
             "examples executed in #{white formatted_spec_duration} seconds.\n"
      end
    end
  end
end
