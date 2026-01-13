# Delete selected elements from a ts_tree_jsonc object

Delete selected elements from a ts_tree_jsonc object

## Usage

``` r
# S3 method for class 'ts_tree_jsonc'
ts_tree_delete(tree, ...)
```

## Arguments

- tree:

  A `ts_tree` object.

- ...:

  Reserved for future use.

## Value

The modified `ts_tree` object with the selected elements removed.

## Details

The formatting of the rest of the document is left as is.

Comments appearing inside the deleted elements are also deleted. Other
comments are left as is.

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
