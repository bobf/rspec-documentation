# frozen_string_literal: true

module RSpecDocumentation
  # Compiles CSS assets into a single file.
  class StylesheetBundle
    def flush
      Util.bundle_dir.join('assets').mkpath
      stylesheet_bundle_path.write(RSpecDocumentation.template(:layout, :css).result(binding))
    end

    private

    def stylesheet_bundle_path
      Util.bundle_dir.join('assets/bundle.css')
    end
  end
end
