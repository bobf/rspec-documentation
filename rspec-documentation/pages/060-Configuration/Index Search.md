# Index Search

The index above the navigation tree is enabled by default.

To disable the index search, set `config.index_search = false`:

```ruby
# rspec-documentation/spec_helper.rb

RSpec::Documentation.configure do |config|
  config.index_search = false
end
```
