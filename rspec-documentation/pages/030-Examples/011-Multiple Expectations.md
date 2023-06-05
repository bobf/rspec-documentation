# Multiple Expectations

Add as many expectations as you like:

## Markdown

````markdown
```rspec
subject { 'my value' }

it { is_expected.to eql 'my value' }
it { is_expected.to be_a String }
```
````

## Output

```rspec
subject { 'my value' }

it { is_expected.to eql 'my value' }
it { is_expected.to be_a String }
```
