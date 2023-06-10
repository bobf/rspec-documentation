# RSpec::Documentation

_RSpec Documentation_ provides a simple but powerful system for generating _Ruby_ documentation using [_RSpec_](https://rspec.info/) designed to help you ensure that all code examples in your documentation really work.

* Create a tree of _Markdown_ files in your project directory under `rspec-documentation/pages/`.
* Embed tests in ```` ```rspec ```` code blocks (other output formatters are available - see examples).
* Define a `subject` for each test.
* Run the provided `rspec-documentation` command.

There is no _DSL_ to learn and vanilla _RSpec_ examples are used to generate inputs and outputs. No _Markdown_ language extensions are used, simply define the language of a fenced code block as `rspec` in any `.md` file and _RSpecDocumentation_ will do the rest.

## Quick Example

The following is an example _Markdown_ file.

````markdown
# An example test

This is a very simple test:

```rspec
subject { 'my subject' }
it { is_expected.to eql 'my subject' }
```
````

## Documentation

View the [full documentation](https://docs.bob.frl/rspec-documentation) (built using Rspec Documentation!) for detailed usage instructions.
