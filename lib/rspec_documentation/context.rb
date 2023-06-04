# frozen_string_literal: true

module RSpecDocumentation
  # Used to fetch missing methods called in examples, provides a context available to all
  # examples to avoid repeated setup in each example. Usage:
  #
  # ```ruby
  # RSpec::Documentation.configure do |config|
  #   config.context do |context|
  #     context.my_value = 'example value'
  #   end
  # end
  # ```
  #
  # `my_value` will now be available in every example.
  class Context
    def initialize
      @context = {}
    end

    def each(&block)
      @context.each(&block)
    end

    private

    def method_missing(key, *args, &block)
      return _assign(key, *args, &block) if key.to_s.end_with?('=')
      return super unless @context.key?(key)

      @context.fetch(key)
    end

    def respond_to_missing?(_key, *_)
      true
    end

    def _assign(key, *args, &block)
      key = key.to_s.rpartition('=').first.to_sym

      @context[key] = if block_given?
                        block
                      else
                        args.first
                      end
    end
  end
end
