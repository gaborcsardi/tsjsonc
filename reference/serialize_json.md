# Serialize an R object to JSON

Create JSON from an R object. Note that this function is not a generic
serializer that can represent any R object in JSON. Also, you cannot
expect that
[`unserialize_json()`](https://gaborcsardi.github.io/tsjson/reference/unserialize_json.md)
will do the exact inverse of `serialize_json()`.

## Usage

``` r
serialize_json(obj, file = NULL, collapse = FALSE, options = NULL)
```

## Arguments

- obj:

  R object to serialize.

- file:

  If not `NULL` then the result if written to this file.

- collapse:

  If `file` is `NULL` then whether to return a character scalar or a
  character vector.

- options:

  List of options, see
  [`tsjson_options()`](https://gaborcsardi.github.io/tsjson/reference/tsjson_options.md).
  This argument must be named and cannot be abbreviated.

## Value

If `file` is `NULL` then a character scalar (`collapse` = TRUE) or
vector (`collapse` = FALSE). If `file` is not `NULL` then nothing.

## Details

tsjson functions
[`update_selected()`](https://gaborcsardi.github.io/tsjson/reference/update_selected.md)
and
[`insert_into_selected()`](https://gaborcsardi.github.io/tsjson/reference/insert_into_selected.md)
use `serialize_json()` to create new JSON code.

See the examples below on how to create all possible JSON elements with
`serialize_json()`.

## See also

[`unserialize_json()`](https://gaborcsardi.github.io/tsjson/reference/unserialize_json.md)
for the opposite.

## Examples

``` r
# null
serialize_json(NULL)
#> [1] "null"

# true, false, use a logical scalar
serialize_json(TRUE)
#> [1] "true"
serialize_json(FALSE)
#> [1] "false"

# strings, use a character scalar
serialize_json("string with escapes: \b \ud020")
#> [1] "\"string with escapes: \\b 퀠\""

# number, use a numeric scalar
serialize_json(42.25)
#> [1] "42.25"

# array, use an unnamed list, i.e. _not_ an atomic vector
txt <- serialize_json(list(1, 2, 3,"x", "y"))
load_json(text = txt)
#> # json (7 lines)
#> 1 | [
#> 2 |   1,
#> 3 |   2,
#> 4 |   3,
#> 5 |   "x",
#> 6 |   "y"
#> 7 | ]

# empty array
serialize_json(list())
#> [1] "[]"

# object, use a named (or partially named) list, i.e. _not_ an atomic vector
txt <- serialize_json(list(a = 1, b = 2))
load_json(text = txt)
#> # json (4 lines)
#> 1 | {
#> 2 |   "a": 1,
#> 3 |   "b": 2
#> 4 | }

# empty object, use a named empty list
serialize_json(structure(list(), names = character()))
#> [1] "{}"
```
