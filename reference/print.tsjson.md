# Print a tsjson object

Calls
[`format.tsjson()`](https://gaborcsardi.github.io/tsjson/reference/format.tsjson.md)
to format the tsjson object, writes the formatted object to the standard
output, and returns the original object invisibly.

## Usage

``` r
# S3 method for class 'tsjson'
print(x, n = 10, ...)
```

## Arguments

- x:

  tsjson object.

- n:

  Number of lines, or number of selections to print.

- ...:

  Ignored.

## Value

`x`, invisibly.

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
