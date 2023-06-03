# frozen_string_literal: true

module RSpecDocumentation
  # Outputs a string containing ANSI color code escape sequences into HTML with attached classes
  # for each matched color code. Cleans any remaining escape codes.
  class AnsiHTML
    COLOR_CODES = [0, 1, 2, 3, 4, 5, 6, 7, 9].freeze

    def initialize(content)
      @content = content
    end

    def render
      "<div class='ansi-html border m-1 p-4'><span>#{subbed_content}</span></div>"
    end

    private

    attr_reader :content

    def subbed_content
      COLOR_CODES.reduce(subbed_hex_codes) do |string, color_code|
        string.gsub("\e[3#{color_code}m", "</span><span class='ansi-color-#{color_code}'>")
              .gsub("\e[0m", "</span><span class='ansi-color-reset'>")
      end.gsub(/\e\[[0-9]+m/, '')
    end

    def subbed_hex_codes
      content.gsub(/\e\[38;2;([0-9]+);([0-9]+);([0-9]+)m/, '</span><span style="color: rgb(\1,\2,\3)">')
    end
  end
end
