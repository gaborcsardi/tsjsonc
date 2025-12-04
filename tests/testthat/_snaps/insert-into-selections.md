# ts_tree_insert

    Code
      ts_tree_insert(ts_tree_select(json, "b"), "foo", at = 1, options = list(format = "auto"))
    Output
      # jsonc (1 line)
      1 | { "a": true, "b": [ 1, "foo", 2, 3 ] }

# ts_tree_insert with empty selection

    Code
      ts_tree_insert(ts_tree_select(json, "new"), "foo", options = list(format = "auto"))
    Output
      # jsonc (1 line, 0 selected elements)
      1 | { "a": true, "b": [1, 2, 3] }

# ts_tree_insert multi-line array is pretty

    Code
      ts_tree_insert(ts_tree_select(json, "b"), list(a = 1, b = 2), options = list(
        format = "auto"))
    Output
      # jsonc (9 lines)
      1 | { "a": true, "b": [
      2 |     1,
      3 |     2,
      4 |     3,
      5 |     {
      6 |         "a": 1,
      7 |         "b": 2
      8 |     }
      9 | ] }

# ts_tree_insert with compact array is compact

    Code
      ts_tree_insert(ts_tree_select(json, "b"), list(1, 2), options = list(format = "auto"))
    Output
      # jsonc (1 line)
      1 | { "a":true, "b":[1,2,3,[1,2]] }

# ts_tree_insert document

    Code
      ts_tree_insert(json, list(a = 1, b = 2), options = list(format = "auto"))
    Output
      # jsonc (4 lines)
      1 | {
      2 |   "a": 1,
      3 |   "b": 2
      4 | }

# ts_tree_insert object

    Code
      ts_tree_insert(ts_tree_select(json, "a"), 42, key = "b", options = list(format = "auto"))
    Output
      # jsonc (1 line)
      1 | { "a": { "b": 42 } }

---

    Code
      ts_tree_insert(ts_tree_select(json, "a"), 43, key = "c", options = list(format = "auto"))
    Output
      # jsonc (1 line)
      1 | { "a": { "b": 42, "c": 43 } }

# ts_tree_insert force formatting

    Code
      ts_tree_insert(ts_tree_select(json, "b"), list(1, 2), options = list(format = "pretty"))
    Output
      # jsonc (9 lines)
      1 | { "a":true, "b":[
      2 |     1,
      3 |     2,
      4 |     3,
      5 |     [
      6 |         1,
      7 |         2
      8 |     ]
      9 | ] }

# insert_into_document errors

    Code
      insert_into_document(json, "true", "pretty")
    Condition
      Error in `insert_into_document()`:
      ! Cannot insert JSON element at the document root if the document already has other non-comment elements.

# ts_tree_insert adds newline if needed

    Code
      ts_tree_insert(json, list(a = 1, b = 2), options = list(format = "auto"))
    Output
      # jsonc (5 lines)
      1 | // comment
      2 | {
      3 |     "a": 1,
      4 |     "b": 2
      5 | }

---

    Code
      ts_tree_insert(json, list(a = 1, b = 2), options = list(format = "auto"))
    Output
      # jsonc (6 lines)
      1 | // comment
      2 | // comment2
      3 | {
      4 |     "a": 1,
      5 |     "b": 2
      6 | }

# ts_tree_insert invalid index

    Code
      ts_tree_insert(ts_tree_select(json, "b"), "foo", at = "bar", options = list(
        format = "auto"))
    Condition
      Error in `insert_into_array()`:
      ! Invalid `at` value for inserting JSON element into array. It must be an integer scalar or `Inf`.

# ts_tree_insert insert into empty array

    Code
      ts_tree_insert(ts_tree_select(json, "b"), "foo", options = list(format = "auto"))
    Output
      # jsonc (1 line)
      1 | { "a": true, "b": ["foo"] }

# ts_tree_insert insert at beginning of array

    Code
      ts_tree_insert(ts_tree_select(json, "b"), "foo", at = 0, options = list(format = "auto"))
    Output
      # jsonc (1 line)
      1 | { "a": true, "b": ["foo",1] }

# ts_tree_insert insert into object by key

    Code
      ts_tree_insert(json, "val", key = "key", at = "a", options = list(format = "auto"))
    Output
      # jsonc (1 line)
      1 | { "a": true, "key": "val", "b": [ 1 ] }

# ts_tree_insert insert into object by non-existing key

    Code
      ts_tree_insert(json, "val", key = "key", at = "nope", options = list(format = "auto"))
    Output
      # jsonc (1 line)
      1 | { "a": true, "b": [ 1 ], "key": "val" }

# ts_tree_insert insert into object at be beginning

    Code
      ts_tree_insert(json, "val", key = "key", at = 0, options = list(format = "auto"))
    Output
      # jsonc (1 line)
      1 | { "key": "val", "a": true, "b": [ 1 ] }

# insert_into_array, comment is kept on same line

    Code
      json
    Output
      # jsonc (3 lines)
      1 | { "a": [1, 2 // comment
      2 | ]
      3 | }
    Code
      ts_tree_insert(ts_tree_select(json, "a"), 42, at = Inf)
    Output
      # jsonc (6 lines)
      1 | { "a": [
      2 |     1,
      3 |     2, // comment
      4 |     42
      5 | ]
      6 | }
    Code
      ts_tree_insert(ts_tree_select(json, "a"), 42, at = 2)
    Output
      # jsonc (6 lines)
      1 | { "a": [
      2 |     1,
      3 |     2, // comment
      4 |     42
      5 | ]
      6 | }

# insert_into_array, multiple comments before comma

    Code
      json
    Output
      # jsonc (5 lines)
      1 | { "a": [1
      2 | // comment1
      3 | // comment2
      4 | , 2]
      5 | }
    Code
      ts_tree_insert(ts_tree_select(json, "a"), 42, at = 1)
    Output
      # jsonc (9 lines)
      1 | { "a": [
      2 |     1
      3 |     // comment1
      4 |     // comment2
      5 |     ,
      6 |     42,
      7 |     2
      8 | ]
      9 | }

# insert_into_object, comment is kept on same line

    Code
      json
    Output
      # jsonc (3 lines)
      1 | { "a": 1, // comment
      2 |   "b": 2
      3 | }
    Code
      ts_tree_insert(json, 42, key = "x", at = "a")
    Output
      # jsonc (5 lines)
      1 | {
      2 |     "a": 1, // comment
      3 |     "x": 42,
      4 |     "b": 2
      5 | }

# insert_into_object, multiple comments before comma

    Code
      json
    Output
      # jsonc (5 lines)
      1 | { "a": 1
      2 | // comment1
      3 | // comment2
      4 | , "b": 2
      5 | }
    Code
      ts_tree_insert(json, 42, at = "a", key = "x")
    Output
      # jsonc (8 lines)
      1 | {
      2 |     "a": 1
      3 |     // comment1
      4 |     // comment2
      5 |     ,
      6 |     "x": 42,
      7 |     "b": 2
      8 | }

# insert_into_array, trailing comma and appending

    Code
      json
    Output
      # jsonc (2 lines)
      1 | [1,2,3,//comment
      2 | ]
    Code
      ts_tree_insert(json, 4)
    Output
      # jsonc (6 lines)
      1 | [
      2 |     1,
      3 |     2,
      4 |     3, //comment
      5 |     4,
      6 | ]

# insert_into_object, trailing comma and appending

    Code
      json
    Output
      # jsonc (2 lines)
      1 | { "a": 1, "b": 2, "c": 3, // comment
      2 | }
    Code
      ts_tree_insert(json, key = "d", 4)
    Output
      # jsonc (6 lines)
      1 | {
      2 |     "a": 1,
      3 |     "b": 2,
      4 |     "c": 3, // comment
      5 |     "d": 4,
      6 | }

