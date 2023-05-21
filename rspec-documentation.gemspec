# frozen_string_literal: true

require_relative 'lib/rspec/documentation/version'

Gem::Specification.new do |spec|
  spec.name = 'rspec-documentation'
  spec.version = Rspec::Documentation::VERSION
  spec.authors = ['Bob Farrell']
  spec.email = ['git@bob.frl']

  spec.summary = 'RSpec documentation tool.'
  spec.description = 'Generates documentation from RSpec code blocks in Markdown files.'
  spec.homepage = 'https://github.com/bobf/rspec-documentation'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.metadata['rubygems_mfa_required'] = 'true'
end
