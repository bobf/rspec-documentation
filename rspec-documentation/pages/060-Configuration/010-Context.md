# Context

You may want to set up some default context that is available in every example so that you don't have to repeat the same setup code each time.

To do this, add the following configuration.

```ruby
RSpec::Documentation.configure do |config|
  config.context do |context|
    context.foo = 'baz'
    context.bar = 'qux'
  end
end
```

`foo` and `baz` will now be available to all examples.

Of course you can still configure `before(:each)` blocks to do setup using regular _RSpec_ configuration in your `rspec-documentation/spec_helper.rb`.

The below example demonstrates the above configuration in action:

```rspec
subject { "#{foo} #{bar}" }

it { is_expected.to eql 'baz qux' }
```
