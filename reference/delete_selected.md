# Delete selected elements from a tsjson object

The formatting of the rest of JSON document is kept as is. Comments
appearing inside the deleted elements are also deleted. Other comments
are left as is.

## Usage

``` r
delete_selected(json)
```

## Arguments

- json:

  tsjson object.

## Value

Modified tsjson object.

## Details

If `json` has no selection then the the whole document is deleted. If
`json` has an empty selection, then nothing is delted.

## Examples

``` r
json <- load_json(text = "{ \"a\": //comment\ntrue, \"b\": [1, 2, 3] }")
json
#> # json (2 lines)
#> 1 | { "a": //comment
#> 2 | true, "b": [1, 2, 3] }

json |> select("a")
#> # json (2 lines, 1 selected element)
#>   1 | { "a": //comment
#> > 2 | true, "b": [1, 2, 3] }
json |> select("a") |> delete_selected()
#> # json (1 line)
#> 1 | { "b": [1, 2, 3] }
```
