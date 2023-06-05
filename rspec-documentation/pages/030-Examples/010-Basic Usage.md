# Basic Examples

## One-liners

This example uses a regular ```` ```rspec ```` code block.

The spec defines a `subject`, a simple comparison is made on its value to satisfy the test, and the value of `subject` is viewable on the _Output_ tab.

Any _RSpec_ test that defines a `subject` is valid, including one-liner syntax like this:

### Markdown

````markdown
```rspec
subject { 'my value' }

it { is_expected.to eql 'my value' }
```
````

### Output

```rspec
subject { 'my value' }

it { is_expected.to eql 'my value' }
```
