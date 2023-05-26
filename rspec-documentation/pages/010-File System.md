# File System

The default directory where _RSpec Documentation_ will look for your _Markdown_ files is `rspec-documentation/pages`.

Add as many files as you like and use you like into the root directory or subdirectories to generate the documentation tree.

## Example Directory Structure

```
rspec-documentation/
└── pages/
    ├── Introduction.md
    ├── File System/
    │   └── Ordering.md
    └── File System.md
```

## Subdirectories

Creating a subdirectory inside `rspec-documentation/pages` adds a new node to the index tree. Add files or more subdirectories to build the tree.

The file you are reading now is located in `rspec-documentation/pages/File System.md`.

There is also a directory named `rspec-documentation/pages/File System` which contains a file named `Ordering.md`.

Take a look at the [source](https://github.com/bobf/rspec-documentation/blob/main/rspec-documentation/pages/) to see how it works.
