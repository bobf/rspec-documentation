# frozen_string_literal: true

module RSpecDocumentation
  # An element in a page tree, generates a single entry as a list item, linked to the relevant
  # document (or just a text entry if no document exists, i.e. if it is a directory without an
  # index file).
  class PageTreeElement
    def initialize(path:, child:)
      @path = path
      @child = child
      @nodes = []
    end

    def node
      return nil if entry_and_directory?

      nodes.push('<li>')
      nodes.push(link) if entry?
      nodes.push(bullet) unless entry?
      nodes.push('</li>')
      nodes
    end

    private

    attr_reader :path, :child, :nodes

    def entry_and_directory?
      return false unless path.join(child).sub_ext('.md').file?
      return false unless path.join(child).sub_ext('').directory?
      return false unless path.join(child).file?

      true
    end

    def entry?
      path.join(child).sub_ext('.md').file?
    end

    def link
      "<a href='#{href}'>#{title}</a>"
    end

    def bullet
      "<b>#{title}</b>"
    end

    def href
      Util.bundle_path(path.join(child))
    end

    def title
      Util.label(child)
    end
  end
end
