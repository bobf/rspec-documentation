# Regular `it` blocks

## Markdown

````markdown
```rspec
subject(:value) { 'my other value' }

it 'contains some expected text' do
  expect(subjvalue).to eql 'other value'
end
```
````

## Output

```rspec
subject(:value) { 'my other value' }

it 'contains some expected text' do
  expect(value).to include 'other value'
end
```
