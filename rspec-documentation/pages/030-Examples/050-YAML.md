# YAML

If your code outputs _YAML_, use the ```` ```rspec:yaml ```` formatter to prettify your _YAML_ output. Note that your code must produce a raw _YAML_ string in order to use this formatter, it does not convert _Ruby_ objects into _YAML_.

## Markdown

````markdown
```rspec:yaml
subject(:yaml) do
  {
    'key' => 'value',
    'array' => [1, 2, 3],
    'boolean' => true,
    'otherBoolean' => false
  }.to_yaml
end

it 'has expected key/value' do
  expect(YAML.safe_load(yaml)).to include({ 'key' => 'value' })
end
```
````

## Output

```rspec:yaml
subject(:yaml) do
  {
    'key' => 'value',
    'array' => [1, 2, 3],
    'boolean' => true,
    'otherBoolean' => false
  }.to_yaml
end

it 'has expected key/value' do
  expect(YAML.safe_load(yaml)).to include({ 'key' => 'value' })
end
```
