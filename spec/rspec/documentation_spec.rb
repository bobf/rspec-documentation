# frozen_string_literal: true

RSpec.describe RSpec::Documentation do
  it 'has a version number' do
    expect(RSpec::Documentation::VERSION).not_to be_nil
  end
end
