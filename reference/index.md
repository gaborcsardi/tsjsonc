# Package index

## Quickstart

- See
  [quickstart](https://gaborcsardi.github.io/tsjson/reference/quickstart.md)
  for a quick demonstration of tsjson.
- See
  [`serialize_json()`](https://gaborcsardi.github.io/tsjson/reference/serialize_json.md)
  to create JSON from R.
- See
  [`unserialize_json()`](https://gaborcsardi.github.io/tsjson/reference/unserialize_json.md)
  to parse JSON into R.
- See
  [`load_json()`](https://gaborcsardi.github.io/tsjson/reference/load_json.md),
  [`select()`](https://gaborcsardi.github.io/tsjson/reference/select.md),
  and
  [`unserialize_selected()`](https://gaborcsardi.github.io/tsjson/reference/unserialize_selected.md)
  to parse parts of JSON into R.
- See
  [`load_json()`](https://gaborcsardi.github.io/tsjson/reference/load_json.md),
  [`select()`](https://gaborcsardi.github.io/tsjson/reference/select.md),
  [`format_selected()`](https://gaborcsardi.github.io/tsjson/reference/format_selected.md),
  and
  [`save_json()`](https://gaborcsardi.github.io/tsjson/reference/save_json.md)
  to format parts of a JSON file or string and save it to a file.
- See
  [`load_json()`](https://gaborcsardi.github.io/tsjson/reference/load_json.md),
  [`select()`](https://gaborcsardi.github.io/tsjson/reference/select.md),
  [`delete_selected()`](https://gaborcsardi.github.io/tsjson/reference/delete_selected.md),
  [`insert_into_selected()`](https://gaborcsardi.github.io/tsjson/reference/insert_into_selected.md),
  [`update_selected()`](https://gaborcsardi.github.io/tsjson/reference/update_selected.md),
  and
  [`save_json()`](https://gaborcsardi.github.io/tsjson/reference/save_json.md)
  to edit a JSON file or string and save it to a file.

## Serialization

- [`serialize_json()`](https://gaborcsardi.github.io/tsjson/reference/serialize_json.md)
  : Serialize an R object to JSON
- [`unserialize_json()`](https://gaborcsardi.github.io/tsjson/reference/unserialize_json.md)
  : Unserialize a JSON file or string into an R object

## Printing

- [`format(`*`<tsjson>`*`)`](https://gaborcsardi.github.io/tsjson/reference/format.tsjson.md)
  : Format a tsjson object
- [`print(`*`<tsjson>`*`)`](https://gaborcsardi.github.io/tsjson/reference/print.tsjson.md)
  : Print a tsjson object

## Extraction

- [`load_json()`](https://gaborcsardi.github.io/tsjson/reference/load_json.md)
  : Parse a JSON file or string into a tsjson object
- [`select()`](https://gaborcsardi.github.io/tsjson/reference/select.md)
  [`` `[[`( ``*`<tsjson>`*`)`](https://gaborcsardi.github.io/tsjson/reference/select.md)
  [`select_refine()`](https://gaborcsardi.github.io/tsjson/reference/select.md)
  : Select elements in a tsjson object
- [`select_query()`](https://gaborcsardi.github.io/tsjson/reference/select_query.md)
  : Select the nodes matching a tree-sitter query in a tsjson object

## Manipulation

- [`delete_selected()`](https://gaborcsardi.github.io/tsjson/reference/delete_selected.md)
  : Delete selected elements from a tsjson object
- [`` `select<-`() ``](https://gaborcsardi.github.io/tsjson/reference/select-set.md)
  [`` `[[<-`( ``*`<tsjson>`*`)`](https://gaborcsardi.github.io/tsjson/reference/select-set.md)
  : Update selected elements in a tsjson object
- [`format_selected()`](https://gaborcsardi.github.io/tsjson/reference/format_selected.md)
  : Format the selected JSON elements
- [`insert_into_selected()`](https://gaborcsardi.github.io/tsjson/reference/insert_into_selected.md)
  : Insert a new element into the selected ones in a tsjson object
- [`save_json()`](https://gaborcsardi.github.io/tsjson/reference/save_json.md)
  : Write a tsjson object to a file
- [`unserialize_selected()`](https://gaborcsardi.github.io/tsjson/reference/unserialize_selected.md)
  : Unserialize selected elements from a tsjson object
- [`update_selected()`](https://gaborcsardi.github.io/tsjson/reference/update_selected.md)
  : Replace selected JSON elements with a new element
- [`select()`](https://gaborcsardi.github.io/tsjson/reference/select.md)
  [`` `[[`( ``*`<tsjson>`*`)`](https://gaborcsardi.github.io/tsjson/reference/select.md)
  [`select_refine()`](https://gaborcsardi.github.io/tsjson/reference/select.md)
  : Select elements in a tsjson object

## Utilities and Options

- [`query_json()`](https://gaborcsardi.github.io/tsjson/reference/query_json.md)
  : Run tree-sitter queries on a JSON file or string
- [`sexpr_json()`](https://gaborcsardi.github.io/tsjson/reference/sexpr_json.md)
  : Show the syntax tree structure of a JSON file or string
- [`syntax_tree_json()`](https://gaborcsardi.github.io/tsjson/reference/syntax_tree_json.md)
  : Show the annotated syntax tree of a JSON file or string
- [`token_table()`](https://gaborcsardi.github.io/tsjson/reference/token_table.md)
  : Get the token table of a JSON file or string
- [`tsjson_options`](https://gaborcsardi.github.io/tsjson/reference/tsjson_options.md)
  : tsjson options
- [`` `[`( ``*`<tsjson>`*`)`](https://gaborcsardi.github.io/tsjson/reference/tsjson-brackets.md)
  : Convert a tsjson object to a data frame
