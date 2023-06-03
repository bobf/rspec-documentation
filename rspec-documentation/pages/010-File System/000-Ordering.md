# Ordering

If you want to specify a specific order that each item will appear in the documentation tree, simply prefix each file or directory with a number and a dash. The filename will be normalized when the documentation is generated.

It is recommended to use increments of 10 when naming files to simplify re-ordering things later:

```console
rspec-documentation/
└── pages/
    ├── 000-Introduction.md
    ├── 010-File System/
    │   └── 000-Ordering.md
    └── 010-File System.md
```
