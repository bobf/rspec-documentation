## HTML

Setting the code block language to `rspec:html` indicates that the output should be treated as _HTML_ which adds a tab displaying auto-formatted _HTML_ and another tab showing the rendered output.

## Markdown

````markdown
```rspec:html
subject do
<<~HTML
  <table class="table">
    <thead>
      <tr><th>Heading 1</th><th>Heading 2</th></tr>
    </thead>
    <tbody>
      <tr><td>Value 1</td><td>Value 2</td></tr>
      <tr><td>Value 3</td><td>Value 4</td></tr>
    </tbody>
  </table>
  HTML
end

it { is_expected.to include 'Value 1' }
```
````

## Output

```rspec:html
subject do
<<~HTML
  <table class="table">
    <thead>
      <tr><th>Heading 1</th><th>Heading 2</th></tr>
    </thead>
    <tbody>
      <tr><td>Value 1</td><td>Value 2</td></tr>
      <tr><td>Value 3</td><td>Value 4</td></tr>
    </tbody>
  </table>
  HTML
end

it { is_expected.to include 'Value 1' }
```
