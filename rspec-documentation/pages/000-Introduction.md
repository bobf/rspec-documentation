# RSpec Documentation

_RSpec Documentation_ provides a simple but powerful system for generating _Ruby_ documentation using [_RSpec_](https://rspec.info/), designed to help you ensure that all code examples in your documentation really work.

Here's an example:

```rspec
subject { 'my subject' }
it { is_expected.to eql 'my subject' }
```

And the _Markdown_ that created it:

````markdown
```rspec
subject { 'my subject' }
it { is_expected.to eql 'my subject' }
```
````

See the [Quickstart](quickstart.html) setup guide to build your first _RSpec Documentation_ project.

Browse the [Examples](examples.html) to get a better idea of the typical usage patterns.
