# Show the annotated syntax tree of a JSON file or string

Show the annotated syntax tree of a JSON file or string

## Usage

``` r
syntax_tree_json(
  file = NULL,
  text = NULL,
  ranges = NULL,
  fail_on_parse_error = TRUE,
  options = NULL
)
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

- fail_on_parse_error:

  Logical, whether to error if there are parse errors in the JSON
  document. Default is `TRUE`.

- options:

  List of options, see
  [`tsjson_options()`](https://gaborcsardi.github.io/tsjson/reference/tsjson_options.md).
  This argument must be named and cannot be abbreviated.

## Examples

``` r
syntax_tree_json(text = "{ \"a\": true, \"b\": [1, 2, 3] }")
#> document                  1|
#> └─object                   |
#>   ├─{                      |{
#>   ├─pair                   |
#>   │ ├─string               |
#>   │ │ ├─"                  |  "
#>   │ │ ├─string_content     |   a
#>   │ │ └─"                  |    "
#>   │ ├─:                    |     :
#>   │ └─true                 |       true
#>   ├─,                      |           ,
#>   ├─pair                   |
#>   │ ├─string               |
#>   │ │ ├─"                  |             "
#>   │ │ ├─string_content     |              b
#>   │ │ └─"                  |               "
#>   │ ├─:                    |                :
#>   │ └─array                |
#>   │   ├─[                  |                  [
#>   │   ├─number             |                   1
#>   │   ├─,                  |                    ,
#>   │   ├─number             |                      2
#>   │   ├─,                  |                       ,
#>   │   ├─number             |                         3
#>   │   └─]                  |                          ]
#>   └─}                      |                            }
```
