# frozen_string_literal: true

module RSpecDocumentation
  # An element in a page tree, generates a single entry as a list item, linked to the relevant
  # document (or just a text entry if no document exists, i.e. if it is a directory without an
  # index file).
  class PageTreeElement
    def initialize(path:, child:, current_path:)
      @path = path
      @child = child
      @current_path = current_path
      @nodes = []
      raise MissingFileError, "Missing file: #{entry_path.relative_path_from(Util.base_dir)}" unless entry?
    end

    def node
      return nil if entry_and_directory?

      nodes.push(li_open)
      nodes.push(link)
      nodes.push('</li>')
      nodes
    end

    private

    attr_reader :path, :child, :current_path, :nodes

    def entry_and_directory?
      return false unless path.join(child).sub_ext('.md').file?
      return false unless path.join(child).sub_ext('').directory?
      return false unless path.join(child).file?

      true
    end

    def entry_path
      path.join(child).sub_ext('.md')
    end

    def entry?
      entry_path.file?
    end

    def li_open
      "<li id='#{Util.path_id(path.join(child))}' #{active_class} data-list-item-id='##{path_id}' " \
        "data-parent-id='##{parent_path_id}'>"
    end

    def link
      "<a href='#{href}'>#{title}</a>"
    end

    def path_id
      @path_id ||= Util.path_id(path.join(child))
    end

    def parent_path_id
      @parent_path_id ||= Util.path_id(path)
    end

    def active_class
      active? ? 'class="active"' : nil
    end

    def href
      Util.href(path.join(child))
    end

    def active?
      Util.bundle_path(current_path) == href
    end

    def title
      Util.label(child)
    end
  end
end
