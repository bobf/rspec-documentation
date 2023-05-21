# frozen_string_literal: true

module RSpecDocumentation
  # A hierarchical structure of all pages in the documentation tree. Used for rendering a navigation section.
  class PageTree
    def initialize(page_paths:)
      @page_paths = page_paths
      @structure = {}
      @nodes = []
    end

    def elements
      build_nodes
      nodes.flatten
    end

    private

    attr_reader :page_paths, :structure, :nodes

    def tree
      @tree ||= begin
        build_tree
        structure
      end
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    # TODO: Refactor.
    def build_nodes(root: tree['rspec-documentation']['pages'], path: root_path.join('rspec-documentation/pages'))
      root[:children].sort.map do |child|
        nodes.push('<li>')
        if path.join(child).sub_ext('.html').file?
          nodes.push("<a href='#{path.join(child).sub_ext('.html')}'>#{child.gsub(/\.md$/, '')}</a>")
        else
          nodes.push("<b>#{child.gsub(/\.md$/, '')}</b>")
        end
        nodes.push('</li>')
        nodes.push('<ul>')
        build_nodes(root: root[child], path: path.join(child)) unless root[child].nil?
        nodes.push('</ul>')
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    # rubocop:disable Metrics/AbcSize
    # TODO: Refactor.
    def build_tree(branch: structure, depth: 0)
      normalized_paths.each do |path|
        first, second, *rest = path.to_s.split('/')[depth..]
        next if second.nil?

        branch[first] ||= {}
        branch[first][:children] ||= Set.new
        branch[first][:children].add(second)
        build_tree(branch: branch[first], depth: depth + 1)
      end
    end
    # rubocop:enable Metrics/AbcSize

    def normalized_paths
      @normalized_paths ||= page_paths.sort.map do |path|
        path.relative_path_from(root_path)
      end
    end

    def root_path
      @root_path ||= Pathname.new(Dir.pwd)
    end
  end
end
