# frozen_string_literal: true

module RSpecDocumentation
  # Compiles Javascript assets into a single file.
  class JavascriptBundle
    def flush
      Util.bundle_dir.join('assets').mkpath
      javascript_bundle_path.write(RSpecDocumentation.template(:layout, :js).result(binding))
    end

    private

    def javascript_bundle_path
      Util.bundle_dir.join('assets/bundle.js')
    end
  end
end
