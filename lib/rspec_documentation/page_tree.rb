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
      build_nodes(
        root: tree['rspec-documentation']['pages'],
        path: root_path.join('rspec-documentation/pages')
      )
      nodes.flatten.compact
    end

    private

    attr_reader :page_paths, :structure, :nodes

    def tree
      @tree ||= begin
        build_tree
        structure
      end
    end

    def build_nodes(root:, path:)
      root[:children].sort.map do |child|
        node = page_tree_node(path: path, child: child)
        next nil if node.nil?

        nodes.concat(node)
        nodes.push('<ul>')
        build_nodes(root: root[child], path: path.join(child)) unless root[child].nil?
        nodes.push('</ul>')
      end
    end

    def build_tree(branch: structure, depth: 0)
      normalized_paths.each do |path|
        first, second, *rest = path_segments(path: path, depth: depth)
        next if second.nil?

        branch[first] ||= {}
        branch[first][:children] ||= Set.new
        branch[first][:children].add(second)
        build_tree(branch: branch[first], depth: depth + 1)
      end
    end

    def path_segments(path:, depth:)
      path.to_s.split('/')[depth..]
    end

    def root_path
      @root_path ||= Pathname.new(Dir.pwd)
    end

    def normalized_paths
      @normalized_paths ||= page_paths.sort.map do |path|
        path.relative_path_from(root_path)
      end
    end

    def page_tree_node(path:, child:)
      PageTreeElement.new(path: path, child: child).node
    end
  end
end
