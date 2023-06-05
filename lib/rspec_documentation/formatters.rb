# frozen_string_literal: true

require_relative 'formatters/ruby'
require_relative 'formatters/html'
require_relative 'formatters/ansi'
require_relative 'formatters/json'
require_relative 'formatters/yaml'
require_relative 'formatters/xml'

module RSpecDocumentation
  # Provides a set of formatters for rendering the value of a `subject` in an RSpec example into
  # a useful format according to the language specified in the relevant Markdown code block, e.g.
  # `rspec:html` will use the `Html` formatter to render beautified HTML source and the rendered
  # output.
  module Formatters
    def self.with_translated_html_entities(content)
      content&.gsub("\n", '<br/>')
             &.gsub('  ', '&nbsp;&nbsp;')
    end
  end
end
