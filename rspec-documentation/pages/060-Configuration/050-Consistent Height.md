# Consistent Height

Depending on your preferences, you may want to force a consistent height for tab content in each rendered example. To configure this option, set `config.consistent_height` to `true` or `false`. The default is `false`.

Setting a consistent height on output prevents content from jumping when each tab is opened but it can also result in quite large gaps beneath examples.

The max height for each example can also be configured by setting `config.max_height`, with the default being `30rem`.

```ruby
# rspec-documentation/spec_helper.rb

RSpec::Documentation.conifgure do |config|
  config.consistent_height = true # Default: false
  config.max_height = '20rem' # Default: 30rem
end
```
