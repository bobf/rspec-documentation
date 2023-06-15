# Quickstart

Install _RSpec Documentation_:

```console
$ gem install rspec-documentation
```

Or add to your `Gemfile`:

```ruby
gem 'rspec-documentation'
```

Initialize your project:

```console
$ rspec-documentation
```

A few placeholder files with a basic example spec will be automatically generated. See the [File System](file-system.html) section for full details on the directory layout.

The documentation generator will provide you with a link to your interactive documentation bundle. Open it in your browser and then start adding specs to more _Markdown_ files. When you're ready, upload the static documentation bundle to your favourite _CDN_.

Whenever you add a `.md` file to your `rpsec-documentation/pages` directory, run `rspec-documentation` again to re-build your documentation bundle.
