# JSON

If your code outputs _JSON_, use the ```` ```rspec:json ```` formatter to prettify your _JSON_ output. Note that your code must produce a raw _JSON_ string in order to use this formatter, it does not convert _Ruby_ objects into _JSON_.

## Markdown

````markdown
```rspec:json
subject(:json) do
  {
    'key' => 'value',
    'array' => [1, 2, 3],
    'boolean' => true,
    'otherBoolean' => false
  }.to_json
end

it 'has expected key/value' do
  expect(JSON.parse(json)).to include({ 'key' => 'value' })
end
```
````

## Output

```rspec:json
subject(:json) do
  {
    'key' => 'value',
    'array' => [1, 2, 3],
    'boolean' => true,
    'otherBoolean' => false
  }.to_json
end

it 'has expected key/value' do
  expect(JSON.parse(json)).to include({ 'key' => 'value' })
end
```
