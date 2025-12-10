# ts_tree_update

    Code
      ts_tree_update(ts_tree_select(json, "a"), list("new", "element"))
    Output
      # jsonc (4 lines)
      1 | { "a": [
      2 |   "new",
      3 |   "element"
      4 | ], "b": [1, 2, 3] }

# ts_tree_update with empty selection can be an insert

    Code
      upd <- ts_tree_update(ts_tree_select(json, "new", "element"), list("new",
        "value"), options = list(format = "pretty"))
      print(upd, n = Inf)
    Output
      # jsonc (14 lines)
       1 | {
       2 |     "a": true,
       3 |     "b": [
       4 |         1,
       5 |         2,
       6 |         3
       7 |     ],
       8 |     "new": {
       9 |         "element": [
      10 |             "new",
      11 |             "value"
      12 |         ]
      13 |     }
      14 | }

# updated_selected with empry non-character selection is noop

    Code
      upd <- ts_tree_update(ts_tree_select(json, "b", 10), list("new", "value"))
      print(upd, n = Inf)
    Output
      # jsonc (1 line, 0 selected elements)
      1 | { "a": true, "b": [1, 2, 3] }

