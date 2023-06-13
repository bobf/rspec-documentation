# Attribution

The default attribution is at the bottom of this page. You are free to either set your own custom attribution or remove it completely.

## Custom Attribution

```ruby
# rspec-documentation/spec_helper.rb

RSpec::Documentation.configure do |config|
  config.attribution = 'Copyright &copy;2023 <a href="https://example.com/">Acme Inc.</a>'
end
```

## Remove Attribution

```ruby
# rspec-documentation/spec_helper.rb

RSpec::Documentation.configure do |config|
  config.attribution = nil
end
```
