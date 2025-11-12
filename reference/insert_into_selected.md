# Insert a new element into the selected ones in a tsjson object

Insert a new element into each selected array or object.

## Usage

``` r
insert_into_selected(json, new, key = NULL, at = Inf, options = NULL)
```

## Arguments

- json:

  tsjson object

- new:

  New element to insert. Will be serialized with
  [`serialize_json()`](https://gaborcsardi.github.io/tsjson/reference/serialize_json.md).

- key:

  Key of the new element, when inserting into an object.

- at:

  What position to insert the new element at:

  - `0`: at the beginning,

  - `Inf`: at the end,

  - other numbers: after the specified element,

  - a character scalar, the key after which the new element is inserted,
    if that key exists, when inserting into an object. If this key does
    not exist, then the new element is inserted at the end of the
    object.

- options:

  List of options, see
  [`tsjson_options()`](https://gaborcsardi.github.io/tsjson/reference/tsjson_options.md).
  This argument must be named and cannot be abbreviated.

## Value

The modified tsjson object.

## Details

It is an error trying to insert into an element that is not an array and
not an object.

## Examples

``` r
json <- load_json(text = "{ \"a\": true, \"b\": [1, 2, 3] }")
json
#> # json (1 line)
#> 1 | { "a": true, "b": [1, 2, 3] }

json |> select("b") |> insert_into_selected("foo", at = 1)
#> # json (6 lines)
#> 1 | { "a": true, "b": [
#> 2 |     1,
#> 3 |     "foo",
#> 4 |     2,
#> 5 |     3
#> 6 | ] }
```
