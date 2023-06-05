## Regular `it` blocks

### Markdown

````markdown
```rspec
subject { 'my value' }

it 'contains some expected text' do
  expect(subject).to eql 'my value'
end
```
````

### Output

```rspec
subject { 'my other value' }

it 'contains some expected text' do
  expect(subject).to include 'other value'
end
```
