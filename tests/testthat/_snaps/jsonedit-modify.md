# can modify objects by name

    Code
      ts_tree_update(ts_tree_select(ts_tree_read_jsonc(text = "{}"), "foo"), 1)
    Output
      # jsonc (3 lines)
      1 | {
      2 |     "foo": 1
      3 | }

---

    Code
      ts_tree_update(ts_tree_select(ts_tree_read_jsonc(text = "{}"), "foo"), 1:2)
    Output
      # jsonc (6 lines)
      1 | {
      2 |     "foo": [
      3 |         1,
      4 |         2
      5 |     ]
      6 | }

---

    Code
      ts_tree_update(ts_tree_select(ts_tree_read_jsonc(text = "{}"), "foo"), list(1,
        "x"))
    Output
      # jsonc (6 lines)
      1 | {
      2 |     "foo": [
      3 |         1,
      4 |         "x"
      5 |     ]
      6 | }

# modification retains comments

    Code
      ts_tree_update(ts_tree_select(ts_tree_read_jsonc(text = text), "foo"), 0)
    Output
      # jsonc (14 lines)
       1 | 
       2 | {
       3 |     // a
       4 |     "foo": 0, // b
       5 |     "bar": [
       6 |         // c
       7 |         1,
       8 |         2, // d
       9 |         // e
      10 |         3
      i 4 more lines
      i Use `print(n = ...)` to see more lines

---

    Code
      ts_tree_update(ts_tree_select(ts_tree_read_jsonc(text = text), "bar", 2), 0)
    Output
      # jsonc (14 lines)
       1 | 
       2 | {
       3 |     // a
       4 |     "foo": 1, // b
       5 |     "bar": [
       6 |         // c
       7 |         1,
       8 |         0, // d
       9 |         // e
      10 |         3
      i 4 more lines
      i Use `print(n = ...)` to see more lines

---

    Code
      print(ts_tree_insert(ts_tree_select(ts_tree_read_jsonc(text = text), "bar"), 0,
      at = 2), n = 20)
    Output
      # jsonc (15 lines)
       1 | 
       2 | {
       3 |     // a
       4 |     "foo": 1, // b
       5 |     "bar": [
       6 |         // c
       7 |         1,
       8 |         2, // d
       9 |         0,
      10 |         // e
      11 |         3
      12 |     ] // f
      13 |     // g
      14 | }
      15 |   

---

    Code
      print(ts_tree_update(ts_tree_select(ts_tree_read_jsonc(text = text), "new"), 0),
      n = 20)
    Output
      # jsonc (15 lines)
       1 | 
       2 | {
       3 |     // a
       4 |     "foo": 1, // b
       5 |     "bar": [
       6 |         // c
       7 |         1,
       8 |         2, // d
       9 |         // e
      10 |         3
      11 |     ], // f
      12 |     "new": 0
      13 |     // g
      14 | }
      15 |   

# can't modify non-object non-array parents

    Code
      ts_tree_update(ts_tree_select(ts_tree_read_jsonc(text = "1"), "foo"), 0)
    Condition
      Error in `FUN()`:
      ! Cannot insert into a 'number' JSON element. Can only insert into 'array' and 'object' elements and empty JSON documents.

---

    Code
      ts_tree_update(ts_tree_select(ts_tree_read_jsonc(text = "\"a\""), "foo"), 0)
    Condition
      Error in `FUN()`:
      ! Cannot insert into a 'string' JSON element. Can only insert into 'array' and 'object' elements and empty JSON documents.

---

    Code
      ts_tree_update(ts_tree_select(ts_tree_read_jsonc(text = "true"), "foo"), 0)
    Condition
      Error in `FUN()`:
      ! Cannot insert into a 'true' JSON element. Can only insert into 'array' and 'object' elements and empty JSON documents.

---

    Code
      ts_tree_update(ts_tree_select(ts_tree_read_jsonc(text = "null"), "foo"), 0)
    Condition
      Error in `FUN()`:
      ! Cannot insert into a 'null' JSON element. Can only insert into 'array' and 'object' elements and empty JSON documents.

