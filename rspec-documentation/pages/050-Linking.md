# Linking

Linking to another file in your documentation is easy. Use relative paths and apply the following simple transformation to your `.md` filename:

* Convert spaces to dashes.
* Lower-case all alphabetical characters.
* Remove any numerical ordering prefixes (see [Ordering](ordering.html)).
* Swap the `.md` extension for `.html`.

## Example

Linking to the [Spec Helper](spec-helper.html) page using the following _Markdown_:

````markdown
# rspec-documentation/pages/050-Linking.md

Linking to the [Spec Helper](spec-helper.html) page using the following _Markdown_:
````

The original filename in this case is `040-Spec Helper.md`.
