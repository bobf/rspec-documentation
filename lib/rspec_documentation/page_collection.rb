# frozen_string_literal: true

module RSpecDocumentation
  # Builds content for a collection of page paths, collates failures from embedded examples.
  # Writes the final structure to disk.
  class PageCollection
    attr_reader :failures, :page_paths

    include Paintbrush

    def initialize(page_paths:)
      @page_paths = page_paths.sort_by(&:to_s)
      @buffer = {}
      @failures = []
    end

    def generate
      page_paths.zip(documents).each do |path, document|
        buffer[bundle_path_for(path)] = document.render
        failures.concat(document.failures)
        break if RSpecDocumentation.configuration.fail_fast && !failures.empty?
      end
    end

    def documents
      @documents ||= page_paths.map do |path|
        Document.new(document: path.read, path: path, page_tree: page_tree(path: path))
      end
    end

    def flush
      Util.bundle_dir.rmtree if Util.bundle_dir.directory?
      Util.bundle_dir.mkpath

      buffer.each do |path, content|
        path.dirname.mkpath
        Util.bundle_path(path).write(content)
      end
      write_index unless buffer.empty?
    end

    def examples_count
      documents.map(&:specs).flatten.size
    end

    private

    attr_reader :buffer

    def write_index
      _path, content = buffer.first
      Util.bundle_index_path.write(content)
    end

    def page_tree(path:)
      PageTree.new(page_paths: page_paths, current_path: path)
    end

    def bundle_path_for(path)
      Util.bundle_path(path)
    end

    def root_path
      Pathname.new(Dir.pwd).join('rspec-documentation')
    end
  end
end
