# Unserialize selected elements from a tsjson object

Uses
[`unserialize_json()`](https://gaborcsardi.github.io/tsjson/reference/unserialize_json.md)
on the selected elements.

## Usage

``` r
unserialize_selected(json)
```

## Arguments

- json:

  tsjson object.

## Value

List of R objects, each the unserialization of a selected element in
tsjson.

## Details

If `json` does not have a selection, then all of it is unserialized. If
`json` has an empty selection, then an empty list is returned.

## See also

[`unserialize_json()`](https://gaborcsardi.github.io/tsjson/reference/unserialize_json.md)
to unserialize a JSON document from a file or string.
[`serialize_json()`](https://gaborcsardi.github.io/tsjson/reference/serialize_json.md)
to create JSON from R objects.

## Examples

``` r
json <- load_json(text = serialize_json(list(
  a = list(a1 = list(1,2,3), a2 = "string"),
  b = list(4, 5, 6),
  c = list(c1 = list("a", "b"))
)))
json |> select(c("b", "c")) |> unserialize_selected()
#> [[1]]
#> [[1]][[1]]
#> [1] 4
#> 
#> [[1]][[2]]
#> [1] 5
#> 
#> [[1]][[3]]
#> [1] 6
#> 
#> 
#> [[2]]
#> [[2]]$c1
#> [[2]]$c1[[1]]
#> [1] "a"
#> 
#> [[2]]$c1[[2]]
#> [1] "b"
#> 
#> 
#> 
```
