# frozen_string_literal: true

module RSpecDocumentation
  # Misc utility classes for functionality shared between components, helpers for path normalization.
  class Util
    ORDERING_PREFIX_REGEXP = /^[0-9]+-/.freeze

    def self.bundle_path(path)
      relative_path = Pathname.new(path).relative_path_from(base_dir)
      bundle_dir.join(Pathname.new(normalized_filename(relative_path)).sub_ext('.html'))
    end

    def self.base_dir
      root_dir.join('rspec-documentation', 'pages')
    end

    def self.bundle_dir
      return root_dir.join('rspec-documentation', 'bundle') unless ENV.key?('RSPEC_DOCUMENTATION_BUNDLE_PATH')

      Pathname.new(ENV.fetch('RSPEC_DOCUMENTATION_BUNDLE_PATH'))
    end

    def self.root_dir
      Pathname.new(Dir.pwd)
    end

    def self.label(path)
      Pathname.new(path).basename.sub_ext('').sub(ORDERING_PREFIX_REGEXP, '')
    end

    def self.normalized_filename(path)
      path.to_s.gsub(' ', '-').downcase.sub(ORDERING_PREFIX_REGEXP, '')
    end
  end
end
