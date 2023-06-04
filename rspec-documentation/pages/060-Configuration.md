# Configuration

Most _RSpecDocumentation_ features work out of the box, but you may need to configure certain features if the default configuration doesn't suit your needs.

Create a [spec helper](spec-helper.html) and add the following block of code:

```ruby
RSpec::Documentation.configure do |config|
  # your config goes here
end
```

See each section of the configuration documentation for available options.
