# frozen_string_literal: true

module RSpecDocumentation
  # A hierarchical structure of all pages in the documentation tree. Used for rendering a navigation section.
  class PageTree
    def initialize(page_paths:, current_path:)
      @page_paths = page_paths
      @current_path = current_path
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

    attr_reader :page_paths, :structure, :nodes, :current_path

    def tree
      @tree ||= begin
        build_tree
        structure
      end
    end

    def build_nodes(root:, path:)
      root[:children].sort.each do |child|
        node = page_tree_node(path: path, child: child)
        next nil if node.nil?

        li_open, *li_body, li_close = node
        nodes.push(li_open)
        nodes.concat(li_body)
        push_children(root: root, path: path, child: child)
        nodes.push(li_close)
      end
    end

    def push_children(root:, path:, child:)
      nodes.push('<ol>')
      build_nodes(root: root[child], path: path.join(child)) unless root[child].nil?
      nodes.last == '<ol>' ? nodes.pop : nodes.push('</ol>')
    end

    def build_tree(paths: normalized_paths, branch: structure, depth: 0)
      paths.each do |path|
        first, second, *rest = path_segments(path: path, depth: depth)
        next if second.nil?

        branch[first] ||= {}
        branch[first][:children] ||= Set.new
        branch[first][:children].add(second)
        build_tree(paths: filtered_paths(path), branch: branch[first], depth: depth + 1)
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

    def filtered_paths(path)
      normalized_paths.select { |normalized_path| normalized_path.to_s.start_with?(path.sub_ext('').to_s) }
    end

    def page_tree_node(path:, child:)
      PageTreeElement.new(path: path, child: child, current_path: current_path).node
    end
  end
end
