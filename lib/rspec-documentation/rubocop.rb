# frozen_string_literal: true

require 'rspec/documentation'
require_relative 'rubocop/ruby_extractor'

# XXX: This is the "official" way to create a Rubocop plugin, all code below this comment is
# taken directly from here:
# https://github.com/rubocop/rubocop-extension-generator/blob/master/lib/rubocop/extension/generator/generator.rb

# The original code is from https://github.com/rubocop/rubocop-rspec/blob/master/lib/rubocop/rspec/inject.rb
# See https://github.com/rubocop/rubocop-rspec/blob/master/MIT-LICENSE.md
module RuboCop
  # RuboCop extension for RSpec::Documentation
  module RSpecDocumentation
    PROJECT_ROOT   = Pathname.new(__dir__).parent.parent.expand_path.freeze
    CONFIG_DEFAULT = PROJECT_ROOT.join('lib/rspec-documentation/rubocop/default.yml').freeze
    CONFIG         = YAML.safe_load(CONFIG_DEFAULT.read).freeze

    private_constant(:CONFIG_DEFAULT, :PROJECT_ROOT)

    # Because RuboCop doesn't yet support plugins, we have to monkey patch in a bit of our configuration.
    module Inject
      def self.defaults!
        path = CONFIG_DEFAULT.to_s
        hash = ConfigLoader.send(:load_yaml_configuration, path)
        config = Config.new(hash, path).tap(&:make_excludes_absolute)
        puts "configuration from \#{path}" if ConfigLoader.debug?
        config = ConfigLoader.merge_with_default(config, path)
        ConfigLoader.instance_variable_set(:@default_configuration, config)
      end
    end
  end
end

RuboCop::RSpecDocumentation::Inject.defaults!
