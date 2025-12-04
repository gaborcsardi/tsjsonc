# Write a tsjsonc object to a file

Write a tsjsonc object to a file

## Arguments

- json:

  tsjsonc object.

- file:

  File or connection to write to. Both binary and text connections are
  supported. Use
  [`stdout()`](https://rdrr.io/r/base/showConnections.html) to output to
  the screen.

## Value

Nothing.

## See also

[`ts_read_jsonc()`](https://gaborcsardi.github.io/tsjsonc/reference/ts_parse_jsonc.md)
to create a tsjsonc object from a JSON file or string.
[`ts::ts_tree_unserialize()`](https://gaborcsardi.github.io/ts/reference/ts_tree_unserialize.html)
obtain a JSON string for a tsjsonc object.
