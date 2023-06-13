# Hooks

_RSpec::Documentation_ provides hooks for inserting content into various places rendered _HTML_ documents for each page of your documentation.

To configure hooks, add the following to `rspec-documentation/spec_helper.rb`:

```ruby
RSpec::Documentation.configure do |config|
  config.hook(:after_head) { '<style>h1 { font-size: 10rem; }</style>' }
end
```

In practice you will most likely load content from a file using `File.read` or similar. You are free to store supplementary content anywhere in your project, e.g. you may want to create `rspec-documentation/assets` and create a hook such as:

```ruby
RSpec::Documentation.configure do |config|
  config.hook(:after_head) do
    "<script>#{File.read('rspec-documentation/assets/fontawesome.js')}</script>"
  end
end
```

## Available Hooks

| Hook | Description |
|-|-|
| `after_head` | Inserts content immediately before the closing `</head>` tag, after the default head content. Use this to override any styling or add `<script>` and `<link>` tags. |
| `after_header` | Inserts content immediately after the main document header. Use this to insert custom content underneath the header for each page. |
| `before_content` | Inserts content immediately before the main document content, between the navigation tree and each rendered documentation page. |
| `after_content` | Inserts content immediately after the main documentation content, before the footer. |
| `after_footer` | Inserts content immediately below the footer. |
