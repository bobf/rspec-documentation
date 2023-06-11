# Table of Contents

A table of contents for each page is generated by default. The items in the table of contents are derived from the headers in each section (i.e. _Markdown_ elements defined with one or more `#` characters).

To disable the table of contents, set `config.table_of_contents` to `false`:

```ruby
# spec/spec_helper.rb

RSpec::Documentation.configure do |config|
  config.table_of_contents = false # Default: true
end
```

## Overriding for Specific Pages

If you want to disable the Table of Contents globally but enable for specific pages, add the following anywhere in your _Markdown_ document:

```markdown
* TOC
{:toc}
```

## Omit a Specific Header from Table of Contents

To omit a specific header element from the Table of Contents, add `{:.no_toc}` underneath the header:

```markdown
## Header included in Table of Contents

## Header not included in Table of Contents
{:.no_toc}
```

See the [`kramdown` documentation](https://kramdown.gettalong.org/converter/html.html#toc) for more details. Aside from injecting _RSpec_ examples into the output, each _Markdown_ document is passed transparently to _kramdown_ for processing.