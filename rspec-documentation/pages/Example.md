# Example

## Example Output

```rspec
foo = '<span>hello</span>'

it_documents foo, format: :html do
  expect('example output').to eql 'example output'
end
```
