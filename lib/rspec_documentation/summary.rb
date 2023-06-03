# frozen_string_literal: true

module RSpecDocumentation
  # Provides a summary of the test run including details of any failures.
  class Summary
    include Paintbrush

    def initialize(page_collection:, pwd:)
      @page_collection = page_collection
      @pwd = pwd
    end

    def flush
      if page_collection.failures.empty?
        print_success_summary
      else
        print_failure_summary
      end

      nil
    end

    private

    attr_reader :page_collection, :pwd

    def print_success_summary
      warn(paintbrush { green("\n  All specs passed.") })
      warn(paintbrush { cyan("\n  Created #{blue(page_collection.page_paths.size)} pages.\n") })
      warn(paintbrush { cyan("  View your documentation here: #{blue(bundle_index_path)}\n") })
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

    def failure_summary
      examples = page_collection.examples_count > 1 ? 'examples' : 'example'
      failures = page_collection.failures.size > 1 ? 'failures' : 'failure'
      paintbrush do
        red "#{page_collection.examples_count} #{examples}, #{page_collection.failures.size} #{failures}."
      end
    end

    def failed_examples_summary
      page_collection.failures.map(&:spec).map do |spec|
        paintbrush { red "  #{spec.path.relative_path_from(pwd)}:#{spec.location}" }
      end.join("\n")
    end

    def bundle_index_path
      Util.bundle_path(page_collection.page_paths.first)
    end
  end
end
