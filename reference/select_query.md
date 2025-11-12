# Select the nodes matching a tree-sitter query in a tsjson object

See https://tree-sitter.github.io/tree-sitter/ on writing tree-sitter
queries. Captured nodes of the TOML document will be selected.

## Usage

``` r
select_query(json, query)
```

## Arguments

- json:

  tsjson object.

- query:

  String, a tree-sitter query.

## The JSON grammar

The grammar has the following node types. I included some less important
nodes in the subsection of other nodes that they are related to.

Comments may appear between any tokens, but they are not part of the
grammar.

Use
[`token_table()`](https://gaborcsardi.github.io/tsjson/reference/token_table.md),
[`syntax_tree_json()`](https://gaborcsardi.github.io/tsjson/reference/syntax_tree_json.md)
or
[`sexpr_json()`](https://gaborcsardi.github.io/tsjson/reference/sexpr_json.md)
to explore the parse tree of a JSON document.

### `document`

\#' A document is a single value.

### Values

A value is one of:

- `object`,

- `array`,

- `numebr`,

- `string`,

- `true`,

- `false`,

- `null`.

### `object` / `pair`

An `object` is a sequence of

- `{`,

- zero or more `pair` nodes, separated by `,` nodes, trailing commas are
  allowed,

- `}`.

A pair is a series of

- a key, a `string` node,

- `:`,

- a value (see above).

### `array`

An `array` is a sequence of

- `[`,

- zero or more values (see above), separated by `,` nodes, trailing
  commas are allowed,

- `]`.

### `number`

An integer or floating point number. Minus sign is part of the number.
Scientific notation is supported.

### `string` / `string_content` / `escape_sequence`

A string is a sequence of

- a starting double quote (`"`),

- zero or more `string_content` or `escape_sequence` nodes,

- an ending double quote (`"`).

### `true` / `false` / `null`

The literals `true`, `false`, and `null`.

\[\`,

- zero or more values (see above), separated by `,` nodes, trailing
  commas are allowed,

- \`\]:
  R:%60,%0A-%20zero%20or%20more%20values%20(see%20above),%20separated%20by%20%60,%60%20nodes,%20trailing%0A%20%20commas%20are%20allowed,%0A-%20%60

## See also

[`query_json()`](https://gaborcsardi.github.io/tsjson/reference/query_json.md)
for running a tree sitter query on text and obtaining the result.

## Examples

``` r
# A very simple JSON document
txt <- "{ \"a\": 1, \"b\": \"foo\", \"c\": 20 }"

# Take a look at it
load_json(text = txt) |> format_selected()
#> # json (5 lines)
#> 1 | {
#> 2 |     "a": 1,
#> 3 |     "b": "foo",
#> 4 |     "c": 20
#> 5 | }

# Select all pairs where the value is a number and change them to 100
load_json(text = txt) |>
  select_query("((pair value: (number) @num))") |>
  update_selected(100)
#> # json (1 line)
#> 1 | { "a": 100, "b": "foo", "c": 100}
```
