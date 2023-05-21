# frozen_string_literal: true

RSpec.describe RSpecDocumentation::Spec do # rubocop:disable RSpec/FilePath
  subject(:spec) do
    described_class.new(spec: input, format: format, parent: parent, location: 1, index: 0)
  end

  let(:input) { 'it_documents("foo") { expect("foo").to eql "foo" }' }
  let(:format) { 'html' }
  let(:parent) { instance_double(Kramdown::Element) }
  let(:content) { fixture('basic_spec.rb').read }

  its(:source) { is_expected.to eql 'it_documents("foo") { expect("foo").to eql "foo" }' }

  describe '#run' do
    it 'runs an example' do
      expect(spec.run).to be true
    end

    it 'does not store a failure for a successful test' do
      spec.run
      expect(spec.failure).to be_nil
    end

    context 'with a failing example' do
      let(:input) { 'it_documents("foo") { expect("foo").to eql "bar" }' }

      it 'runs an example' do
        expect(spec.run).to be true
      end

      it 'stores failures' do
        spec.run
        expect(spec.failure).to be_a RSpecDocumentation::RSpec::Failure
      end
    end
  end
end
