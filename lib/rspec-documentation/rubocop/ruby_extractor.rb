# frozen_string_literal: true

module RuboCop
  module RSpecDocumentation
    # Extracts Ruby code from Markdown documentation files and generates an output compatible
    # with RuboCop's code extraction mechanism:
    # https://docs.rubocop.org/rubocop/extensions.html#configuring-an-extension
    class RubyExtractor
      def call(processed_source)
        return nil unless relevant?(processed_source.path)

        specs.select { |spec| spec.path.expand_path.to_s == processed_source.path }
             .map { |spec| extracted_spec(spec, processed_source) }
      end

      private

      def specs
        @specs ||= ::RSpecDocumentation::Documentation.new.page_collection.documents.map(&:specs).flatten
      end

      def relevant?(path)
        path.start_with?(::RSpecDocumentation::Util.base_dir.to_s) && Pathname.new(path).extname == '.md'
      end

      def rspec_documentation_processed_source(spec, processed_source)
        RuboCop::ProcessedSource.new(spec.source, RUBY_VERSION.to_f, processed_source.path)
      end

      def extracted_spec(spec, processed_source)
        {
          offset: spec.path.readlines[...spec.location - 2].sum(&:size),
          processed_source: rspec_documentation_processed_source(spec, processed_source)
        }
      end
    end
  end
end

RuboCop::Runner.ruby_extractors.unshift(RuboCop::RSpecDocumentation::RubyExtractor.new)
