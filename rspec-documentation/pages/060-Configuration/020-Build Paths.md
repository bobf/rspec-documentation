# Build Paths

A handful of environment variables are avaialable to control various build paths.

## `RSPEC_DOCUMENTATION_BUNDLE_PATH`

Set `RSPEC_DOCUMENTATION_BUNDLE_PATH` to output your documentation bundle to somewhere other than `rspec-documentation/bundle/`.

The target directory will always be emptied before generating the output documentation.

```console
$ RSPEC_DOCUMENTATION_BUNDLE_PATH=/tmp/my-documentation-bundle/ rspec-documentation

  All specs passed.

  Created 13 pages.

  View your documentation here: /tmp/my-documentation-bundle/index.html
```

## `RSPEC_DOCUMENTATION_URL_ROOT`

Set `RSPEC_DOCUMENTATION_URL_ROOT` to define the base path that all assets and links should point to. For example, this documentation is deployed to [https://docs.bob.frl/rspec-documentation/](https://docs.bob.frl/rspec-documentation/) so the URL root is `/rspec-documentation`.

```console
$ RSPEC_DOCUMENTATION_URL_ROOT=/rspec-documentation rspec-documentation

  All specs passed.

  Created 13 pages.

  View your documentation here: /home/bob/dev/rspec-documentation/rspec-documentation/bundle/index.html
```
