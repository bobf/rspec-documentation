# frozen_string_literal: true

module RSpecDocumentation
  class MarkdownRenderer < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end
end
