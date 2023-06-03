# Containers

In most cases you will likely want each item in your documentation tree to be paired with a `.md` file, including subdirectories. If you prefer to just have a group of files in the tree under a directory with no parent document then simply create a directory without a matching `.md` file.

e.g. The directory `010-Example Container/` is not paired with a file named `010-Example Container.md` in its parent directory so it appears unlinked in the documentation tree.

```console
rspec-documentation/
└── pages/
    ├── 000-Introduction.md
    ├── 010-File System/
    │   ├── 000-Ordering.md
    │   ├── 010-Containers/
    │   │   └── 010-Example Container/
    │   │       └── Example Page.md
    │   └── 010-Containers.md
    ├── 010-File System.md
    └── 020-Running Specs.md
```
