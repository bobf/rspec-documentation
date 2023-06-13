# Context

You may want to set up some default context that is available in every example so that you don't have to pollute each example with the same repeated code.

To do this, add the following configuration.

```ruby
RSpec::Documentation.configure do |config|
  config.context do
    let(:foo) { 'baz' }
    let(:bar) { 'qux' }
  end
end
```

`foo` and `baz` will now be available to all examples. Under the hood this is just an implicit `RSpec.shared_context` block that is automatically included in every example, so the `let` used here is the same `let` that you're already familiar with and has no hidden caveats.

Of course you can still configure `before(:each)` blocks to do setup using regular _RSpec_ configuration in your `rspec-documentation/spec_helper.rb`.

The below example demonstrates the above configuration in action:

```rspec
subject { "#{foo} #{bar}" }

it { is_expected.to eql 'baz qux' }
```
