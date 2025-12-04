# Delete selected elements from a tsjsonc object

The formatting of the rest of JSON document is kept as is. Comments
appearing inside the deleted elements are also deleted. Other comments
are left as is.

## Usage

``` r
# S3 method for class 'ts_tree_jsonc'
ts_tree_delete(tree, ...)
```

## Arguments

- tree:

  tsjsonc object.

- ...:

  Reserved for future use.

## Value

Modified tsjsonc object.

## Details

If `tree` has no selection then the the whole document is deleted. If
`tree` has an empty selection, then nothing is delted.

## Examples

``` r
library(ts)
tree <- ts_parse_jsonc("{ \"a\": //comment\ntrue, \"b\": [1, 2, 3] }")
tree
#> # jsonc (2 lines)
#> 1 | { "a": //comment
#> 2 | true, "b": [1, 2, 3] }

tree |> ts_tree_select("a")
#> # jsonc (2 lines, 1 selected element)
#> > 1 | { "a": //comment
#>   2 | true, "b": [1, 2, 3] }
tree |> ts_tree_select("a") |> ts_tree_delete()
#> # jsonc (1 line)
#> 1 | { "b": [1, 2, 3] }
```
