# Get the token table of a JSON file or string

Get the token table of a JSON file or string

## Usage

``` r
token_table(
  file = NULL,
  text = NULL,
  ranges = NULL,
  fail_on_parse_error = TRUE,
  options = NULL
)
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

- fail_on_parse_error:

  Logical, whether to error if there are parse errors in the JSON
  document. Default is `TRUE`.

- options:

  List of options, see
  [`tsjson_options()`](https://gaborcsardi.github.io/tsjson/reference/tsjson_options.md).
  This argument must be named and cannot be abbreviated.

## Value

A data frame with one row per token, and columns:

- `id`: integer, the id of the token.

- `parent`: integer, the id of the parent token. The root token has
  parent `NA`

- `field_name`: character, the field name of the token in its parent.

- `type`: character, the type of the token.

- `code`: character, the actual code of the token.

- `start_byte`, `end_byte`: integer, the byte positions of the token in
  the input.

- `start_row`, `start_column`, `end_row`, `end_column`: integer, the
  position of the token in the input.

- `is_missing`: logical, whether the token is a missing token added by
  the parser to recover from errors.

- `has_error`: logical, whether the token has a parse error.

- `children`: list of integer vectors, the ids of the children tokens.

## Examples

``` r
token_table(text = "{ \"a\": true, \"b\": [1, 2, 3] }")
#> # A data frame: 26 × 15
#>       id parent field_name type     code  start_byte end_byte start_row
#>    <int>  <int> <chr>      <chr>    <chr>      <int>    <int>     <int>
#>  1     1     NA NA         "docume…  NA            0       29         0
#>  2     2      1 NA         "object"  NA            0       29         0
#>  3     3      2 NA         "{"      "{"            0        1         0
#>  4     4      2 NA         "pair"    NA            2       11         0
#>  5     5      4 key        "string"  NA            2        5         0
#>  6     6      5 NA         "\""     "\""           2        3         0
#>  7     7      5 NA         "string… "a"            3        4         0
#>  8     8      5 NA         "\""     "\""           4        5         0
#>  9     9      4 NA         ":"      ":"            5        6         0
#> 10    10      4 value      "true"   "tru…          7       11         0
#> # ℹ 16 more rows
#> # ℹ 7 more variables: start_column <int>, end_row <int>,
#> #   end_column <int>, is_missing <lgl>, has_error <lgl>,
#> #   expected <list>, children <I<list>>
```
