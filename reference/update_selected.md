# Replace selected JSON elements with a new element

Replace all selected elements with a new element. If `json` has no
selection then the whole document is replaced. If `json` has an empty
selection, then nothing happens.

## Usage

``` r
update_selected(json, new, options = NULL)
```

## Arguments

- json:

  tsjson object.

- new:

  R object that will be serialized to JSON (using
  [`serialize_json()`](https://gaborcsardi.github.io/tsjson/reference/serialize_json.md))
  and inserted in place of the selected JSON elements.

- options:

  List of options, see
  [`tsjson_options()`](https://gaborcsardi.github.io/tsjson/reference/tsjson_options.md).
  This argument must be named and cannot be abbreviated.

## Value

The updated tsjson object

## Examples

``` r
json <- load_json(text = "{ \"a\": true, \"b\": [1, 2, 3] }")
json
#> # json (1 line)
#> 1 | { "a": true, "b": [1, 2, 3] }

json |> select("a") |> update_selected(list("new", "element"))
#> # json (4 lines)
#> 1 | { "a": [
#> 2 |   "new",
#> 3 |   "element"
#> 4 | ], "b": [1, 2, 3] }
```
