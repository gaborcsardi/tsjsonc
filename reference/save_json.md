# Write a tsjson object to a file

Write a tsjson object to a file

## Usage

``` r
save_json(json, file = NULL)
```

## Arguments

- json:

  tsjson object.

- file:

  File or connection to write to. Both binary and text connections are
  supported. Use
  [`stdout()`](https://rdrr.io/r/base/showConnections.html) to output to
  the screen.

## Value

Nothing.

## See also

[`load_json()`](https://gaborcsardi.github.io/tsjson/reference/load_json.md)
to create a tsjson object from a JSON file or string.
[`unserialize_selected()`](https://gaborcsardi.github.io/tsjson/reference/unserialize_selected.md)
obtain a JSON string for a tsjson object.
