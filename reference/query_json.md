# Run tree-sitter queries on a JSON file or string

See https://tree-sitter.github.io/tree-sitter/ on writing tree-sitter
queries.

## Usage

``` r
query_json(file = NULL, text = NULL, query, ranges = NULL)
```

## Arguments

- file:

  Path of a JSON file. Use either `file` or `text`.

- text:

  JSON string. Use either `file` or `text`.

- query:

  Character string, the tree-sitter query to run.

- ranges:

  Can be used to parse part(s) of the input. It must be a data frame
  with integer columns `start_row`, `start_col`, `end_row`, `end_col`,
  `start_byte`, `end_byte`, in this order.

## Value

A list with entries `patterns` and `matched_captures`. `patterns`
contains information about all patterns in the queries and it is a data
frame with columns: `id`, `name`, `pattern`, `match_count`.
`matched_captures` contains information about all matches, and it has
columns `id`, `pattern`, `match`, `type` `start_byte`, `end_byte`,
`start_row`, `start_column`, `end_row`, `end_column`, `name`, `code`.
The `pattern` column of `matched_captured` refers to the `id` column of
`patterns`.

## Details

See
[`select_query()`](https://gaborcsardi.github.io/tsjson/reference/select_query.md)
for documentation on the nodes in the JSON grammar.

## Examples

``` r
# A very simple JSON document
txt <- "{ \"a\": 1, \"b\": \"foo\", \"c\": 20 }"

# Take a look at it
load_json(text = txt) |> format_selected()
#> # json (5 lines)
#> 1 | {
#> 2 |     "a": 1,
#> 3 |     "b": "foo",
#> 4 |     "c": 20
#> 5 | }

# Select all pairs where the value is a number
query_json(text = txt, query = "((pair value: (number) @num))")
#> $patterns
#> # A data frame: 1 × 4
#>      id name  pattern                           match_count
#>   <int> <chr> <chr>                                   <int>
#> 1     1 NA    "((pair value: (number) @num))\n"           2
#> 
#> $matched_captures
#> # A data frame: 2 × 12
#>      id pattern match type   start_byte end_byte start_row start_column
#>   <int>   <int> <int> <chr>       <int>    <int>     <int>        <int>
#> 1     1       1     1 number          7        8         0            7
#> 2     1       1     2 number         27       29         0           27
#> # ℹ 4 more variables: end_row <int>, end_column <int>, name <chr>,
#> #   code <chr>
#> 
```
