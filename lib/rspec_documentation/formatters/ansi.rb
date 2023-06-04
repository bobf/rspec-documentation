# frozen_string_literal: true

module RSpecDocumentation
  module Formatters
    COLOR_CODES = [0, 1, 2, 3, 4, 5, 6, 7, 9].freeze

    # Outputs a string containing ANSI color code escape sequences into HTML with attached
    # classes for each matched color code. Cleans any remaining escape codes.
    class Ansi
      def initialize(subject:)
        @subject = subject
      end

      def prettified_output
        nil
      end

      def rendered_output
        "<div class='ansi-html border m-1 p-4'><span>#{subbed_content}</span></div>"
      end

      def render_raw?
        false
      end

      private

      attr_reader :subject

      def subbed_content
        COLOR_CODES.reduce(subbed_hex_codes) do |string, color_code|
          string&.gsub("\e[3#{color_code}m", "</span><span class='ansi-color-#{color_code}'>")
                &.gsub("\e[9#{color_code}m", "</span><span class='ansi-bright ansi-color-#{color_code}'>")
                &.gsub(/\e\[38;5;([0-9]{1,3})m/, "</span><span class='ansi-color-\\1'>")
                &.gsub("\e[0m", "</span><span class='ansi-color-reset'>")
        end&.gsub(/\e\[[0-9;]+m/, '')
      end

      def subbed_hex_codes
        subject&.gsub(/\e\[38;2;([0-9]+);([0-9]+);([0-9]+)m/, '</span><span style="color: rgb(\1,\2,\3)">')
      end
    end
  end
end
