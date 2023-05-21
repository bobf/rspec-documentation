# frozen_string_literal: true

module RSpecDocumentation
  module RSpec
    # Replicates behaviour of a regular RSpec example group but also defines `it_documents` as an
    # alias for `it`.
    class ExampleGroup < ::RSpec::Core::ExampleGroup
      def self.it_documents(described_object, &block)
        raise Error, 'Must pass an example object to `it_documents`' if described_object.nil?

        metadata = { described_object: described_object }
        ::RSpec::Core::Example.new(self, 'documentation', metadata, block)
      end

      class << self
        def method_missing(...)
          RSpecDocumentation.context.public_send(...)
        end

        def respond_to_missing?(*args)
          RSpecDocumentation.context.respond_to_missing?(*args)
        end
      end
    end
  end
end
