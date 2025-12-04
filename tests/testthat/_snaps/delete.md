# ts_tree_delete comment is deleted

    Code
      ts_tree_delete(ts_tree_select(json, "a"))
    Output
      # jsonc (1 line)
      1 | { "b": [1, 2, 3] }

# ts_tree_delete comment is preserved

    Code
      ts_tree_delete(ts_tree_select(json, "a"))
    Output
      # jsonc (3 lines)
      1 | { "b": [1, 2, 3]
      2 | //comment
      3 | }

# ts_tree_delete nothing to delete

    Code
      ts_tree_delete(ts_tree_select(json, "c"))
    Output
      # jsonc (1 line)
      1 | { "a": true, "b": [1, 2, 3] }

# ts_tree_delete all elements from an array

    Code
      ts_tree_delete(ts_tree_select(json, "b", 1))
    Output
      # jsonc (1 line)
      1 | { "a": true, "b": [] }

# ts_tree_delete first elements from an array

    Code
      ts_tree_delete(ts_tree_select(json, "b", 1:2))
    Output
      # jsonc (1 line)
      1 | { "a": true, "b": [3] }

# ts_tree_delete middle of an array

    Code
      ts_tree_delete(ts_tree_select(json, "b", 2:3))
    Output
      # jsonc (1 line)
      1 | { "a": true, "b": [1, 4] }

# ts_tree_delete last elements of an array

    Code
      ts_tree_delete(ts_tree_select(json, "b", 3:4))
    Output
      # jsonc (1 line)
      1 | { "a": true, "b": [1, 2] }

# ts_tree_delete whitespace of last element is kept

    Code
      ts_tree_delete(ts_tree_select(json, "b"))
    Output
      # jsonc (2 lines)
      1 | { "a": true 
      2 |  }

