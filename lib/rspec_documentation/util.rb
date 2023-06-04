# frozen_string_literal: true

module RSpecDocumentation
  # Misc utility classes for functionality shared between components, helpers for path normalization.
  class Util
    ORDERING_PREFIX_REGEXP = /^[0-9]+-/.freeze

    def self.bundle_path(path)
      relative_path = Pathname.new(path).relative_path_from(base_dir)
      bundle_dir.join(*relative_path.split.map { |segment| normalized_filename(segment) }).sub_ext('.html')
    end

    def self.bundle_index_path
      bundle_dir.join('index.html')
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

    def self.path_id(path)
      "path-id-#{Digest::SHA256.hexdigest(bundle_path(path).relative_path_from(bundle_dir).to_s)}"
    end

    def self.href(path)
      relative_path = Pathname.new(path).relative_path_from(base_dir)
      url_root.join(*relative_path.split.map { |segment| normalized_filename(segment) }).sub_ext('.html')
    end

    def self.url_root
      return bundle_dir unless ENV.key?('RSPEC_DOCUMENTATION_URL_ROOT')

      Pathname.new(ENV.fetch('RSPEC_DOCUMENTATION_URL_ROOT'))
    end

    def self.assets_root
      url_root.join('assets')
    end

    def self.normalized_filename(path)
      path.to_s.gsub(' ', '-').downcase.sub(ORDERING_PREFIX_REGEXP, '')
    end
  end
end
