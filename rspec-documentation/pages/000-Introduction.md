# RSpec Documentation

_RSpec Documentation_ provides a simple but powerful system for generating _Ruby_ documentation using [_RSpec_](https://rspec.info/).

## Features

* Uses a simple file tree of [Markdown](https://www.markdownguide.org/) files.
* Embed examples in [fenced code blocks](https://www.markdownguide.org/extended-syntax/#fenced-code-blocks).
* Generated documentation includes the original _Ruby_ code and the output of the tested object.
* Formatters for [HTML](https://en.wikipedia.org/wiki/HTML) and [ANSI color codes](https://en.wikipedia.org/wiki/ANSI_escape_code).
* Syntax highlighting for _Ruby_ and _HTML_, auto-formatting of _HTML_ output.
* Outputs a static bundle of _HTML_ files that can be uploaded to e.g. [GitHub Pages](https://pages.github.com/).
* No _DSL_ to learn, simply write a regular spec that defines a `subject`. The value of `subject` is stored and included in your documentation.

This documentation was written using _RSpec Documentation_.

## Quick Example

```rspec:html
subject do
<<~HTML
  <table class="table">
    <thead>
      <tr><th>Heading 1</th><th>Heading 2</th></tr>
    </thead>
    <tbody>
      <tr><td>Value 1</td><td>Value 2</td></tr>
      <tr><td>Value 3</td><td>Value 4</td></tr>
    </tbody>
  </table>
  HTML
end

it { is_expected.to include 'Value 1' }
```

Setting the code block language to `rspec:html` indicates that the output should be treated as _HTML_ which adds a tab displaying auto-formatted _HTML_ and another tab showing the rendered output.

Browse the documentation for more examples and usage patterns.
