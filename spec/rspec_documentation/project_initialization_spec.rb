# frozen_string_literal: true

RSpec.describe RSpecDocumentation::ProjectInitialization do # rubocop:disable RSpec/FilePath
  subject(:project_initialization) { described_class.new }

  describe '#flush' do
    subject(:flush) { project_initialization.flush }

    let!(:tmpdir) { Pathname.new(Dir.mktmpdir('rspec-documentation')) }

    around do |example|
      Dir.chdir(tmpdir) { flush }
      example.call
      tmpdir.rmtree
    end

    it 'creates spec_helper.rb' do
      expect(tmpdir.join('rspec-documentation/spec_helper.rb').read).to include 'RSpec::Documentation.configure'
    end

    it 'creates example pages' do
      entries = tmpdir.join('rspec-documentation/pages').entries.map(&:basename).map(&:to_s)
      expect(entries).to include(*%w[500-License.md 010-Usage.md 000-Introduction.md])
    end
  end
end
