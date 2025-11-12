# Parse a JSON file or string into a tsjson object

Parse a JSON file or string and create a tsjson object that represents
its document. This object can then be queried and manipulated.

## Usage

``` r
load_json(file = NULL, text = NULL, ranges = NULL, options = NULL)
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

A tsjson object.

## Details

tsjson objects have
[`format()`](https://gaborcsardi.github.io/tsjson/reference/format.tsjson.md)
and
[`print()`](https://gaborcsardi.github.io/tsjson/reference/print.tsjson.md)
methods to pretty-print them to the screen.

They can be converted to a data frame using the [single
bracket](https://gaborcsardi.github.io/tsjson/reference/tsjson-brackets.md)
operator.

## See also

[`select()`](https://gaborcsardi.github.io/tsjson/reference/select.md)
to select part(s) of a tsjson object,
[`unserialize_selected()`](https://gaborcsardi.github.io/tsjson/reference/unserialize_selected.md)
to extract the selected part(s),
[`format_selected()`](https://gaborcsardi.github.io/tsjson/reference/format_selected.md)
to format the selected part(s),
[`delete_selected()`](https://gaborcsardi.github.io/tsjson/reference/delete_selected.md),
[`insert_into_selected()`](https://gaborcsardi.github.io/tsjson/reference/insert_into_selected.md)
and
[`update_selected()`](https://gaborcsardi.github.io/tsjson/reference/update_selected.md)
to manipulate it.
[`save_json()`](https://gaborcsardi.github.io/tsjson/reference/save_json.md)
to save the JSON document to a file.

## Examples

``` r
text <- '
{
  "a": 1,
  "b": [2, 3, 4],
  "[r]": {
    "this": "setting",
    // A comment!
    "that": true
  }
}
'

# Parse the JSON, allowing comments (i.e. JSONC)
load_json(text = text)
#> # json (10 lines)
#>  1 | 
#>  2 | {
#>  3 |   "a": 1,
#>  4 |   "b": [2, 3, 4],
#>  5 |   "[r]": {
#>  6 |     "this": "setting",
#>  7 |     // A comment!
#>  8 |     "that": true
#>  9 |   }
#> 10 | }

# Try to parse the JSON, but comments aren't allowed!
try(load_json(text = text, options = list(allow_comments = FALSE)))
#> Error in token_table(text = text, ranges = ranges, options = options) : 
#>   The JSON document contains comments, and this is not allowed. To allow comments, set the `allow_comments` option to `TRUE`.

# Extract parts of the JSON
load_json(text = text) |> select("b") |> unserialize_selected()
#> [[1]]
#> [[1]][[1]]
#> [1] 2
#> 
#> [[1]][[2]]
#> [1] 3
#> 
#> [[1]][[3]]
#> [1] 4
#> 
#> 
load_json(text = text) |> select("[r]") |> unserialize_selected()
#> [[1]]
#> [[1]]$this
#> [1] "setting"
#> 
#> [[1]]$that
#> [1] TRUE
#> 
#> 
load_json(text = text) |> select("[r]", "that") |> unserialize_selected()
#> [[1]]
#> [1] TRUE
#> 

# Use a `list()` combining strings and positional indices when
# arrays are involved
load_json(text = text) |> select("b", 2) |> unserialize_selected()
#> [[1]]
#> [1] 3
#> 
```
