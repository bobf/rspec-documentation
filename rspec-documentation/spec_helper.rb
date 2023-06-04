RSpec::Documentation.configure do |config|
  config.context do |context|
    context.foo = 'baz'
    context.bar = 'qux'
  end
end
