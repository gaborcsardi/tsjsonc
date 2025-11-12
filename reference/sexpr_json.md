# Show the syntax tree structure of a JSON file or string

Show the syntax tree structure of a JSON file or string

## Usage

``` r
sexpr_json(file = NULL, text = NULL, ranges = NULL)
```

## Arguments

- file:

  Path of a JSON file. Use either `file` or `text`.

- text:

  JSON string. Use either `file` or `text`.

- ranges:

  Can be used to parse part(s) of the input. It must be a data frame
  with integer columns `start_row`, `start_col`, `end_row`, `end_col`,
  `start_byte`, `end_byte`, in this order.

## Examples

``` r
sexpr_json(text = "{ \"a\": true, \"b\": [1, 2, 3] }")
#> [1] "(document (object (pair key: (string (string_content)) value: (true)) (pair key: (string (string_content)) value: (array (number) (number) (number)))))"
```
