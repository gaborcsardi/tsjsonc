# Convert a tsjson object to a data frame

Create a data frame for the syntax tree of a JSON document, by indexing
a tsjson object with single brackets. This is occasionally useful for
exploration and debugging.

## Usage

``` r
# S3 method for class 'tsjson'
x[i, j, drop = FALSE]
```

## Arguments

- x:

  tsjson object.

- i, j:

  indices.

- drop:

  Ignored.

## Value

A data frame with columns: `id`, `parent`, `field_name`, `type`, `code`,
`start_byte`, `end_byte`, `start_row`, `start_column`, `end_row`,
`end_column`, `is_missing`, `has_error`, `expected`, `children`, `tws`.

## See also

[`token_table()`](https://gaborcsardi.github.io/tsjson/reference/token_table.md)
to create the token table directly. Other JSON debugging tools:
[`sexpr_json()`](https://gaborcsardi.github.io/tsjson/reference/sexpr_json.md),
[`syntax_tree_json()`](https://gaborcsardi.github.io/tsjson/reference/syntax_tree_json.md),
[`query_json()`](https://gaborcsardi.github.io/tsjson/reference/query_json.md).
[`load_json()`](https://gaborcsardi.github.io/tsjson/reference/load_json.md)
for creating tsjson objects.

## Examples

``` r
json <- load_json(text = serialize_json(list(
  a = list(a1 = list(1,2,3), a2 = "string"),
  b = list(4, 5, 6),
  c = list(c1 = list("a", "b"))
)))

json
#> # json (21 lines)
#>  1 | {
#>  2 |   "a": {
#>  3 |     "a1": [
#>  4 |       1,
#>  5 |       2,
#>  6 |       3
#>  7 |     ],
#>  8 |     "a2": "string"
#>  9 |   },
#> 10 |   "b": [
#> ℹ 11 more lines
#> ℹ Use `print(n = ...)` to see more lines

json[]
#> # A data frame: 81 × 16
#>       id parent field_name type     code  start_byte end_byte start_row
#>    <int>  <int> <chr>      <chr>    <chr>      <int>    <int>     <int>
#>  1     1     NA NA         "docume…  NA            0      167         0
#>  2     2      1 NA         "object"  NA            0      167         0
#>  3     3      2 NA         "{"      "{"            0        1         0
#>  4     4      2 NA         "pair"    NA            4       78         1
#>  5     5      4 key        "string"  NA            4        7         1
#>  6     6      5 NA         "\""     "\""           4        5         1
#>  7     7      5 NA         "string… "a"            5        6         1
#>  8     8      5 NA         "\""     "\""           6        7         1
#>  9     9      4 NA         ":"      ":"            7        8         1
#> 10    10      4 value      "object"  NA            9       78         1
#> # ℹ 71 more rows
#> # ℹ 8 more variables: start_column <int>, end_row <int>,
#> #   end_column <int>, is_missing <lgl>, has_error <lgl>,
#> #   expected <list>, children <I<list>>, tws <chr>
```
