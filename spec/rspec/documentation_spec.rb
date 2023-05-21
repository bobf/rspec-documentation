# frozen_string_literal: true

RSpec.describe Rspec::Documentation do
  it 'has a version number' do
    expect(Rspec::Documentation::VERSION).not_to be_nil
  end
end
