# frozen_string_literal: true

RSpec.describe RSpecDocumentation::Spec do # rubocop:disable RSpec/FilePath
  subject(:spec) do
    described_class.new(spec: input, format: format, parent: parent, location: 1, path: path, index: 0)
  end

  let(:input) { "subject { 'foo' }\nit { is_expected.to eql 'foo' }" }
  let(:format) { 'html' }
  let(:parent) { instance_double(Kramdown::Element) }
  let(:content) { fixture('basic_spec.rb').read }
  let(:path) { Pathname.new('.') }

  its(:source) { is_expected.to eql "subject { 'foo' }\nit { is_expected.to eql 'foo' }" }

  describe '#run' do
    it 'runs an example' do
      expect(spec.run).to be true
    end

    it 'does not store a failure for a successful test' do
      spec.run
      expect(spec.failure).to be_nil
    end

    # TODO: Figure out how to run these within RSpec without them causing the suite to fail from
    # the nested specs.
    #
    # context 'with a failing example' do
    #   let(:input) { "subject { 'foo' }\nit { is_expected.to eql 'bar' }" }
    #
    #   it 'runs an example' do
    #     expect(spec.run).to be true
    #   end
    #
    #   it 'stores failures' do
    #     spec.run
    #     expect(spec.failure).to be_a RSpecDocumentation::RSpec::Failure
    #   end
    # end
  end
end
