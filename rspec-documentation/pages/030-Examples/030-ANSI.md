# ANSI

If your code's output includes colors encoded with [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code) use the ```` ```rspec:ansi ```` formatter to translate the codes into _HTML_.

8-bit colors and _RGB_ color codes are supported.

## Markdown

````markdown
```rspec:ansi
subject do
  "\e[34mfoo\e[0m\e[0m \e[32mbar \e[36mfoo, bar, baz\e[0m\e[32m with " \
  "\e[36mqux\e[0m\e[32m and quux\e[0m\e[0m and corge with " \
  "\e[38;5;153mpale blue and " \
  "\e[38;2;235;12;186mRGB PINK\e[0m\e[0m"
end

it { is_expected.to include "\e[38;2;235;12;186mRGB PINK" }
```
````

## Output

```rspec:ansi
subject do
  "\e[34mfoo\e[0m\e[0m \e[32mbar \e[36mfoo, bar, baz\e[0m\e[32m with " \
  "\e[36mqux\e[0m\e[32m and quux\e[0m\e[0m and corge with " \
  "\e[38;5;153mpale blue and " \
  "\e[38;2;235;12;186mRGB PINK\e[0m\e[0m"
end

it { is_expected.to include "\e[38;2;235;12;186mRGB PINK" }
```
