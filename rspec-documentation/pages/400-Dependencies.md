# Dependencies

_RSpec::Documentation_ has the following notable dependencies:

|Dependency|Purpose|
|-|-|
| [kramdown](https://kramdown.gettalong.org/) | Converts the parsed _Markdown_ document into _HTML_. Highly flexible, allowing _RSpec::Documentation_ to inject examples into the rendered output and perform numerous customizations. |
| [RSpec](https://rspec.info/) | Runs all examples and provides detailed output of failures. |
| [Rouge](https://github.com/rouge-ruby/rouge) | Syntax-highlights _Ruby_, _JSON_, _XML_, and _HTML_ output in examples. |
| [kramdown-parser-gfm](https://github.com/kramdown/parser-gfm) | Extends `kramdown` to provide _GitHub Flavored Markdown_, allowing syntax most developers are familiar with (e.g. triple-backticks for code blocks). |
| [HTML Beautifier](https://github.com/threedaymonk/htmlbeautifier) | Re-formats output generated with the `rspec:hthml` language specifier. |
| [Nokogiri](https://nokogiri.org/) | Re-formats output generated with the `rspec:xml` language specifier. |
| [Paintbrush](https://docs.bob.frl/paintbrush) | String colorization used in various outputs. |
