# Standalone Directories

In most cases you will likely want each node on the tree to link to some content, but if you simply want to add a node to group together some other pages then create a directory without adding a matching _Markdown_ `.md` file.

```
rspec-documentation/
└── pages/
    ├── 000-Introduction.md
    ├── 010-File System/
    │   ├── 000-Ordering.md
    │   ├── 010-Standalone Directories.md
    │   └── 020-Standalone Directory/
    │       └── Example Page.md
    └── 010-File System.md
```

You can see this example standalone directory in the documentation tree on this page.
