# frozen_string_literal: true

module RSpecDocumentation
  # Builds content for a collection of page paths, collates failures from embedded examples.
  # Writes the final structure to disk.
  class PageCollection
    attr_reader :failures

    def initialize(page_paths:)
      @page_paths = page_paths
      @buffer = {}
      @failures = []
    end

    def generate
      page_paths.each do |path|
        document = Document.new(document: path.read, page_tree: page_tree)
        buffer[path] = document.render
        @failures.concat(document.failures)
      end
    end

    def flush
      @buffer.each do |path, content|
        path.sub_ext('.html').write(content)
      end
    end

    private

    attr_reader :page_paths, :buffer

    def page_tree
      PageTree.new(page_paths: page_paths)
    end
  end
end
