# Unserialize a JSON file or string into an R object

The purpose of this function is to convert a JSON file or string into an
R object reliably.

## Usage

``` r
unserialize_json(file = NULL, text = NULL, ranges = NULL, options = NULL)
```

## Arguments

- file:

  Path of a JSON file. Use either `file` or `text`.

- text:

  JSON string. Use either `file` or `text`.

- ranges:

  Can be used to parse part(s) of the input. It must be a data frame
  with integer columns `start_row`, `start_col`, `end_row`, `end_col`,
  `start_byte`, `end_byte`, in this order.

- options:

  List of options, see
  [`tsjson_options()`](https://gaborcsardi.github.io/tsjson/reference/tsjson_options.md).
  This argument must be named and cannot be abbreviated.

## Value

R object.

## Details

See examples below on how the different JSON elements are mapped to R
objects.

## See also

[`serialize_json()`](https://gaborcsardi.github.io/tsjson/reference/serialize_json.md)
for the opposite,
[`select()`](https://gaborcsardi.github.io/tsjson/reference/select.md)
and
[`unserialize_selected()`](https://gaborcsardi.github.io/tsjson/reference/unserialize_selected.md)
to unserialize part(s) of a JSON document.
[`load_json()`](https://gaborcsardi.github.io/tsjson/reference/load_json.md)
to load a JSON document and then manipulate it.

## Examples

``` r
# null -> NULL
unserialize_json(text = "null")
#> NULL

# true, false -> TRUE, FALSE
unserialize_json(text = "true")
#> [1] TRUE
unserialize_json(text = "false")
#> [1] FALSE

# string -> character scalar
unserialize_json(text = "\"string with escapes: \\b \\ud020\"")
#> [1] "string with escapes: \b 퀠"

# number -> double scalar
unserialize_json(text = "42.25")
#> [1] 42.25

# array -> unnamed list
unserialize_json(text = "[1, 2, 3]")
#> [[1]]
#> [1] 1
#> 
#> [[2]]
#> [1] 2
#> 
#> [[3]]
#> [1] 3
#> 

# object -> named list
unserialize_json(text = "{\"a\": 1, \"b\": 2 }")
#> $a
#> [1] 1
#> 
#> $b
#> [1] 2
#> 
```
