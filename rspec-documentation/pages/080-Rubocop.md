# RuboCop

An extension gem for [RuboCop](https://rubocop.org) is available. The extension allows _RuboCop_ to extract all examples from your documentation pages and identify any failures. With the extension enabled, a `rubocop` run will include all of the examples in your documentation seamlessly.

It is highly recommended to use the official [`rubocop-rspec`](https://github.com/rubocop/rubocop-rspec) extension in conjunction with _RSpec::Documentation_.

## Installation

Add the following to your `Gemfile`:

```ruby
gem 'rubocop-rspec-documentation', require: false
```

## Configuration

Add the following configuration to your `.rubocop.yml` to enable the extension:

```yaml
# .rubocop.yml

require:
- rubocop-rspec-documentation
```

_RuboCop_ will now look for files in `rspec-documentation/pages/**/*.md` and the provided extension will do the required parsing/extracting/offsetting, allowing _RuboCop_ to work as normal.

The following cops are disabled for your documentation examples as they cannot be sensibly addressed within each example:

* `Naming/FileName`
* `Gemspec/RequiredRubyVersion`
* `Style/FrozenStringLiteralComment`
* `Lint/RedundantCopEnableDirective`

## Autocorrect

There is currently an issue using auto-correct with _RuboCop_, causing infinite loops with indentation corrections. Possibly a bug in _RuboCop's_ extension mechanism - avoid using auto-correct with your _Markdown_ files until this has been resolved.
