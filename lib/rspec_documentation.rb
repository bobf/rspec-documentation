# frozen_string_literal: true

require 'htmlbeautifier'
require 'kramdown'
require 'kramdown-parser-gfm'
require 'paintbrush'
require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
require 'rspec'
require 'rake'

require 'pathname'
require 'securerandom'

require_relative 'rspec_documentation/rspec'
require_relative 'rspec_documentation/util'
require_relative 'rspec_documentation/context'
require_relative 'rspec_documentation/configuration'
require_relative 'rspec_documentation/document'
require_relative 'rspec_documentation/parsed_document'
require_relative 'rspec_documentation/html_element'
require_relative 'rspec_documentation/ansi_html'
require_relative 'rspec_documentation/spec'
require_relative 'rspec_documentation/markdown_renderer'
require_relative 'rspec_documentation/page_collection'
require_relative 'rspec_documentation/page_tree'
require_relative 'rspec_documentation/page_tree_element'

# Internal module used by RSpec::Documentation to run examples and write output into an HTML document.
module RSpecDocumentation
  class Error < StandardError; end

  def self.root
    Pathname.new(File.dirname(__dir__))
  end

  def self.template(name, format = :html)
    ERB.new(root.join('lib/templates', "#{name}.#{format}.erb").read)
  end

  def self.context
    yield configuration.context if block_given?
    configuration.context
  end

  def self.configure
    yield configuration
  end

  def self.configuration
    @configuration ||= RSpecDocumentation::Configuration.new
  end
end
