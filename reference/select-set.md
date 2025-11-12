# Update selected elements in a tsjson object

Update the selected elements of a JSON document, using the replacement
function syntax.

## Usage

``` r
select(json, ...) <- value

# S3 method for class 'tsjson'
x[[i]] <- value
```

## Arguments

- value:

  New value. Will be serialized to JSON with
  [`serialize_json()`](https://gaborcsardi.github.io/tsjson/reference/serialize_json.md).

- x, json:

  tsjson object. Create a tsjson object with
  [`load_json()`](https://gaborcsardi.github.io/tsjson/reference/load_json.md).

- i, ...:

  Selectors, see
  [`select()`](https://gaborcsardi.github.io/tsjson/reference/select.md).

## Value

The updated tsjson object.

`deleted()` returns a marker object to be used at the right hand side of
the `select<-()` or the double bracket replacement functions, see
examples below.

## Details

Technically `select<-()` is equivalent to
[`select_refine()`](https://gaborcsardi.github.io/tsjson/reference/select.md)
plus
[`update_selected()`](https://gaborcsardi.github.io/tsjson/reference/update_selected.md).
In case when `value` is

`deleted()` is a special marker to delete elements from a tsjson object
with `select<-()` or the double bracket operator.

## See also

Save the updated tjson object to a file with
[`save_json()`](https://gaborcsardi.github.io/tsjson/reference/save_json.md).

## Examples

``` r
json <- load_json(text = "{}")

json <- json |> select("r", "editor.formatOnSave") |> update_selected(TRUE)
json
#> # json (5 lines)
#> 1 | {
#> 2 |     "r": {
#> 3 |         "editor.formatOnSave": true
#> 4 |     }
#> 5 | }

json <- json |> select("r", "editor.formatOnSave") |> delete_selected()
json
#> # json (4 lines)
#> 1 | {
#> 2 |     "r": {
#> 3 |         }
#> 4 | }

# Insert an array
json <- json |> select("foo") |> update_selected(1:3)
json
#> # json (8 lines)
#> 1 | {
#> 2 |     "r": {},
#> 3 |     "foo": [
#> 4 |         1,
#> 5 |         2,
#> 6 |         3
#> 7 |     ]
#> 8 | }

# Update the array at location 2
json |> select("foo", 2) |> update_selected(0)
#> # json (8 lines)
#> 1 | {
#> 2 |     "r": {},
#> 3 |     "foo": [
#> 4 |         1,
#> 5 |         0,
#> 6 |         3
#> 7 |     ]
#> 8 | }

# Insert at location 2
json |> select("foo") |> insert_into_selected(0, at = 2)
#> # json (9 lines)
#> 1 | {
#> 2 |     "r": {},
#> 3 |     "foo": [
#> 4 |         1,
#> 5 |         2,
#> 6 |         0,
#> 7 |         3
#> 8 |     ]
#> 9 | }

# Insert at the end of the array with `Inf` as `at`
json |> select("foo") |> insert_into_selected(0, at = Inf)
#> # json (9 lines)
#> 1 | {
#> 2 |     "r": {},
#> 3 |     "foo": [
#> 4 |         1,
#> 5 |         2,
#> 6 |         3,
#> 7 |         0
#> 8 |     ]
#> 9 | }

# Only the modified elements are reformatted
json <- load_json(text = '{"foo":[1,2],\n"bar":1}')
json |> select("foo") |> insert_into_selected(0, at = Inf)
#> # json (6 lines)
#> 1 | {"foo":[
#> 2 |     1,
#> 3 |     2,
#> 4 |     0
#> 5 | ],
#> 6 | "bar":1}

# You can control how those elements are formatted
json |> select("foo") |>
  insert_into_selected(0, at = Inf, options = list(indent_width = 2))
#> # json (6 lines)
#> 1 | {"foo":[
#> 2 |   1,
#> 3 |   2,
#> 4 |   0
#> 5 | ],
#> 6 | "bar":1}

# Using `deleted()` to delete elements
json <- load_json(text = serialize_json(list(
  a = list(a1 = list(1,2,3), a2 = "string"),
  b = list(4, 5, 6),
  c = list(c1 = list("a", "b"))
)))

select(json, list("a", "a1")) <- deleted()
json
#> # json (16 lines)
#>  1 | {
#>  2 |   "a": {
#>  3 |     "a2": "string"
#>  4 |   },
#>  5 |   "b": [
#>  6 |     4,
#>  7 |     5,
#>  8 |     6
#>  9 |   ],
#> 10 |   "c": {
#> ℹ 6 more lines
#> ℹ Use `print(n = ...)` to see more lines

json[[list("a", "a2")]] <- deleted()
json
#> # json (15 lines)
#>  1 | {
#>  2 |   "a": {
#>  3 |     },
#>  4 |   "b": [
#>  5 |     4,
#>  6 |     5,
#>  7 |     6
#>  8 |   ],
#>  9 |   "c": {
#> 10 |     "c1": [
#> ℹ 5 more lines
#> ℹ Use `print(n = ...)` to see more lines
```
