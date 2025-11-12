# Format a tsjson object

Format a tsjson object for printing.

## Usage

``` r
# S3 method for class 'tsjson'
format(x, n = 10, ...)
```

## Arguments

- x:

  tsjson object.

- n:

  Number of lines, or number of selections to print.

- ...:

  Ignored.

## Value

Character vector.

## Details

This is the engine of
[`print.tsjson()`](https://gaborcsardi.github.io/tsjson/reference/print.tsjson.md),
possibly useful to obtain a printed representation without doing the
actual printing.

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
```
