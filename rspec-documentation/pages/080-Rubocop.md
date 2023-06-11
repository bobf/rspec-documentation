# RuboCop

_RSpec::Documentation_ provides a [RuboCop](https://rubocop.org) extension which allows _RuboCop_ to extract all examples from your documentation pages and identify any failures.

It is highly recommended to use the official [`rubocop-rspec`](https://github.com/rubocop/rubocop-rspec) extension in conjunction with _RSpec::Documentation_.

## Configuration

Add the following configuration to your `.rubocop.yml` to enable the extension:

```yaml
# .rubocop.yml

require:
- rspec-documentation/rubocop
- rubocop-rspec # Omit if you prefer not to use the `rubocop-rspec` extension.
```

_RuboCop_ will now look for files in `rspec-documentation/pages/**/*.md` and the provided extension will do the required parsing/extracting/offsetting, allowing _RuboCop_ to work as normal.

The following cops are disabled as they cannot be sensibly addressed within each example:

* `Naming/FileName`
* `Gemspec/RequiredRubyVersion`
* `Style/FrozenStringLiteralComment`

## Autocorrect

There is currently an issue using auto-correct with _RuboCop_, causing infinite loops with indentation corrections. Possibly a bug in _RuboCop's_ extension mechanism - avoid using auto-correct with your _Markdown_ files until this has been resolved.
