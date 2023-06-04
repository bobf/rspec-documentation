# Spec Helper

_RSpec Documentation_ will load `rspec-documentation/spec_helper.rb` before running your test suite if it is present.

The default `spec/spec_helper.rb` is not loaded by _RSpec Documentation_ unless you explicitly load it from your documentation's `spec_helper.rb`.

This allows you to separate setup and teardown of your documentation environment in case you have different requirements for each context.

There is nothing special about _RSpec Documentation's_ `spec_helper.rb`, but you may want to use some of the available configuration provided.

See the [Configuration](configuration.html) documentation for more details.
