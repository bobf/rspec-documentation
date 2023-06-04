# frozen_string_literal: true

RSpec::Documentation.configure do |config|
  config.context do
    let(:foo) { 'baz' }
    let(:bar) { 'qux' }
  end
end
