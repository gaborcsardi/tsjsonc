# Format the selected JSON elements

Format the selected JSON elements

## Usage

``` r
format_selected(json, options = NULL)
```

## Arguments

- json:

  tsjson object.

- options:

  List of options, see
  [`tsjson_options()`](https://gaborcsardi.github.io/tsjson/reference/tsjson_options.md).
  This argument must be named and cannot be abbreviated.

## Value

The updated tsjson object.

## Details

If `json` does not have a selection, then all of it is formatted. If
`json` has an empty selection, then nothing happens.

## Examples

``` r
json <- load_json(text = "{ \"a\": [1,2,3] }")
json
#> # json (1 line)
#> 1 | { "a": [1,2,3] }

json |> format_selected()
#> # json (7 lines)
#> 1 | {
#> 2 |     "a": [
#> 3 |         1,
#> 4 |         2,
#> 5 |         3
#> 6 |     ]
#> 7 | }

json |> select("a") |> format_selected()
#> # json (5 lines)
#> 1 | { "a": [
#> 2 |     1,
#> 3 |     2,
#> 4 |     3
#> 5 | ] }
```
