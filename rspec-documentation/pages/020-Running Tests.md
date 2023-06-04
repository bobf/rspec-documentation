# Running Tests

To run your test suite, just call the provided `rspec-documentation` command from your project directory:

```console
$ exe/rspec-documentation

  Created 5 pages.

  View your documentation here: /home/bob/dev/rspec-documentation/rspec-documentation/bundle/introduction.html
```

Documentation will only be generated if all tests pass. A summary of failures is provided if the suite does not run successfully:

```console
    # rspec-documentation/pages/030-Examples/010-Basic.md:23

    subject { 'my value' }

    it { is_expected.to eql 'not my value' }


    expected: "not my value"
         got: "my value"

    (compared using eql?)

6 examples, 1 failure.

Failed examples:

  rspec-documentation/pages/030-Examples/010-Basic.md:23
```
