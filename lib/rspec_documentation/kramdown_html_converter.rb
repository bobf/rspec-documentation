# frozen_string_literal: true

module Kramdown
  module Converter
    # Custom HTML converter for kramdown. Invoked with `Kramdown::Document#to_html_rspec_documentation`.
    # Applies a custom CSS class to Markdown tables when rendered to HTML.
    class HtmlRspecDocumentation < Converter::Html
      def convert_table(element, indent)
        element.attr['class'] ||= 'rspec-documentation-table table'
        super
      end

      def convert_header(element, indent)
        [
          '<div class="heading">',
          super,
          "<a class='heading-anchor' href='##{element.attr['id']}'>#{link_icon}</a>",
          '</div>'
        ].join
      end

      def link_icon
        @link_icon ||= RSpecDocumentation.template(:link, :svg).result
      end
    end
  end
end
