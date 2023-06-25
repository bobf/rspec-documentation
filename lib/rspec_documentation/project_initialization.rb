# frozen_string_literal: true

module RSpecDocumentation
  # Initializes a new project if `rspec-documentation/` directory is empty.
  class ProjectInitialization
    include Paintbrush

    def flush
      print_welcome
      create_base_dir
      create_sample_files
      create_spec_helper
      print_initialization_complete
    end

    private

    def print_welcome
      warn(paintbrush { blue "\nWelcome to #{cyan 'RSpec Documentation'}. A new project is being initialized.\n" })
      warn(paintbrush do
        blue "If you want to undo at any point, simply delete the #{cyan 'rspec-documentation/'}  directory.\n"
      end)
    end

    def create_base_dir
      Util.base_dir.mkpath
      print_created(Util.base_dir)
    end

    def create_sample_files
      sample_files.each do |sample_file|
        Util.base_dir.join(sample_file).sub_ext('.md').write(RSpecDocumentation.template(sample_file, :md).result)
        print_created(Util.base_dir.join(sample_file).sub_ext('.md'))
      end
    end

    def create_spec_helper
      return if Util.spec_helper_path.exist?

      Util.spec_helper_path.write(RSpecDocumentation.template(:spec_helper, :rb).result)
      print_created(Util.spec_helper_path)
    end

    def print_created(path)
      warn(paintbrush { "   #{green_b 'create'} #{cyan path.relative_path_from(pwd)}" })
    end

    def print_initialization_complete
      warn(paintbrush do
        blue "\nYour documentation project has been #{green 'initialized'} wlth smoe example pages."
      end)
    end

    def pwd
      Pathname.new(Dir.pwd)
    end

    def sample_files
      %w[000-Introduction 010-Usage 500-License]
    end
  end
end
