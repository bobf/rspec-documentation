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
      page_paths.sort.each do |path|
        document = Document.new(document: path.read, page_tree: page_tree)
        buffer[bundle_path_for(path)] = document.render
        @failures.concat(document.failures)
      end
    end

    def flush
      Util.bundle_dir.rmtree if Util.bundle_dir.directory?
      Util.bundle_dir.mkpath

      @buffer.each do |path, content|
        path.dirname.mkpath
        Util.bundle_path(path).write(content)
      end
    end

    private

    attr_reader :page_paths, :buffer

    def page_tree
      PageTree.new(page_paths: page_paths)
    end

    def bundle_path_for(path)
      Util.bundle_path(path)
    end

    def root_path
      Pathname.new(Dir.pwd).join('rspec-documentation')
    end
  end
end
