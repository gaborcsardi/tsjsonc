# save_json

    Code
      ts_tree_read_jsonc(tmp)
    Output
      # jsonc (test.json, 10 lines)
       1 | {
       2 |   "a": [
       3 |     1,
       4 |     2,
       5 |     3
       6 |   ],
       7 |   "b": {
       8 |     "b1": "foo"
       9 |   }
      10 | }

---

    Code
      ts_tree_write(json)
    Condition
      Error in `ts_tree_write.default()`:
      ! Don't know which file to save JSONC document to. You need to specify the `file` argument.

---

    Code
      ts_tree_read_jsonc(tmp)
    Output
      # jsonc (test.json, 5 lines)
      1 | {
      2 |   "b": {
      3 |     "b1": "foo"
      4 |   }
      5 | }

---

    Code
      ts_tree_write(json, file = stdout())
    Output
      {
        "a": [
          1,
          2,
          3
        ],
        "b": {
          "b1": "foo"
        }
      }

---

    Code
      ts_tree_read_jsonc(tmp2)
    Output
      # jsonc (bin.json, 10 lines)
       1 | {
       2 |   "a": [
       3 |     1,
       4 |     2,
       5 |     3
       6 |   ],
       7 |   "b": {
       8 |     "b1": "foo"
       9 |   }
      10 | }

