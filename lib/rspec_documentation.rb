# frozen_string_literal: true

require 'htmlbeautifier'
require 'kramdown'
require 'kramdown-parser-gfm'
require 'paintbrush'
require 'rouge'
require 'rspec'
require 'rake'

require 'pathname'
require 'securerandom'
require 'digest'
require 'json'
require 'yaml'
require 'date'
require 'time'
require 'pp' # rubocop:disable Lint/RedundantRequireStatement
require 'stringio'

require_relative 'rspec_documentation/rspec'
require_relative 'rspec_documentation/util'
require_relative 'rspec_documentation/summary'
require_relative 'rspec_documentation/project_initialization'
require_relative 'rspec_documentation/configuration'
require_relative 'rspec_documentation/stylesheet_bundle'
require_relative 'rspec_documentation/javascript_bundle'
require_relative 'rspec_documentation/document'
require_relative 'rspec_documentation/parsed_document'
require_relative 'rspec_documentation/html_element'
require_relative 'rspec_documentation/formatters'
require_relative 'rspec_documentation/spec'
require_relative 'rspec_documentation/documentation'
require_relative 'rspec_documentation/page_collection'
require_relative 'rspec_documentation/page_tree'
require_relative 'rspec_documentation/page_tree_element'
require_relative 'rspec_documentation/kramdown_html_converter'

# Internal module used by RSpec::Documentation to run examples and write output into an HTML document.
module RSpecDocumentation
  class Error < StandardError; end
  class MissingFileError < Error; end

  @hooks = {}

  def self.root
    Pathname.new(File.dirname(__dir__))
  end

  def self.template(name, format = :html)
    ERB.new(
      root.join('lib/templates', "#{name}.#{format}.erb").read,
      eoutvar: "@eout#{SecureRandom.hex(16)}"
    )
  end

  def self.theme(name)
    ERB.new(root.join('lib/templates/themes', "#{name}.css").read).result(binding)
  end

  def self.hook(name)
    configuration.hooks.fetch(name, nil)&.call
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
