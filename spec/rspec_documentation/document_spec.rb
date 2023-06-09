# frozen_string_literal: true

RSpec.describe RSpecDocumentation::Document do # rubocop:disable RSpec/FilePath
  subject(:document) { described_class.new(document: markdown, page_tree: page_tree, path: Pathname.new('.')) }

  let(:markdown) { fixture('basic.md').read }
  let(:page_tree) do
    RSpecDocumentation::PageTree.new(page_paths: [fixture('basic.md').path], current_path: Pathname.new('.'))
  end

  it { is_expected.to be_a described_class }

  describe '#specs' do
    subject(:specs) { document.specs }

    it { is_expected.to all be_a(RSpecDocumentation::Spec) }
    it { is_expected.not_to be_empty }
  end
end
