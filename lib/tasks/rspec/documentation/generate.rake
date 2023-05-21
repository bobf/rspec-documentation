# frozen_string_literal: true

namespace :rspec do
  namespace :documentation do
    desc 'Generates documentation from Markdown located in rpsec-documentation/pages'
    task :generate do
      RSpec::Documentation.generate_documentation
    end
  end
end
