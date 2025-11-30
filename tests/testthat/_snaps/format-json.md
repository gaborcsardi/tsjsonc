# ts_format_jsonc

    Code
      ts_format_jsonc(file = tmp)
      writeLines(readLines(tmp))
    Output
      {
          "a": 1,
          "b": {
              "b1": 21,
              "b2": 22
          },
          "c": 3,
          "d": [
              1,
              2,
              3
          ]
      }

# format_selected

    Code
      ts_tree_format(json)
    Output
      # jsonc (13 lines)
       1 | {
       2 |     "a": 1,
       3 |     "b": {
       4 |         "b1": 21,
       5 |         "b2": 22
       6 |     },
       7 |     "c": 3,
       8 |     "d": [
       9 |         1,
      10 |         2,
      i 3 more lines
      i Use `print(n = ...)` to see more lines
    Code
      ts_tree_format(ts_tree_select(json, "a"))
    Output
      # jsonc (1 line)
      1 | {"a":1,"b":{"b1":21,"b2":22},"c":3,"d":[1,2,3]}
    Code
      ts_tree_format(ts_tree_select(json, "b"))
    Output
      # jsonc (4 lines)
      1 | {"a":1,"b":{
      2 |     "b1": 21,
      3 |     "b2": 22
      4 | },"c":3,"d":[1,2,3]}

---

    Code
      ts_tree_format(ts_tree_select(json, "b"))
    Output
      # jsonc (13 lines)
       1 | {
       2 |     "a": 1,
       3 |     "b": {
       4 |         "b1": 21,
       5 |         "b2": 22
       6 |     },
       7 |     "c": 3,
       8 |     "d": [
       9 |         1,
      10 |         2,
      i 3 more lines
      i Use `print(n = ...)` to see more lines

# format_selected null, true, false, string, comment

    Code
      ts_tree_format(json)
    Output
      # jsonc (10 lines)
       1 | {
       2 |     "a": null,
       3 |     "b": true,
       4 |     "c": false,
       5 |     "d": [
       6 |         "a",
       7 |         "b",
       8 |         "c"
       9 |     ]
      10 | }

---

    Code
      ts_tree_format(json)
    Output
      # jsonc (6 lines)
      1 | {
      2 |     // comment
      3 |     "a":
      4 |         // comment
      5 |         null
      6 | }

# format_selected empty array

    Code
      ts_tree_format(json)
    Output
      # jsonc (4 lines)
      1 | {
      2 |     "a": [],
      3 |     "b": true
      4 | }

# format_selected compact arrays

    Code
      json
    Output
      # jsonc (8 lines)
      1 | {
      2 |   "a": [
      3 |     1,
      4 |     2,
      5 |     3
      6 |   ],
      7 |   "b": true
      8 | }
    Code
      ts_tree_format(json, options = list(format = "compact"))
    Output
      # jsonc (1 line)
      1 | {"a":[1,2,3],"b":true}

# format_selected oneline arrays

    Code
      json
    Output
      # jsonc (8 lines)
      1 | {
      2 |   "a": [
      3 |     1,
      4 |     2,
      5 |     3
      6 |   ],
      7 |   "b": true
      8 | }
    Code
      ts_tree_format(json, options = list(format = "oneline"))
    Output
      # jsonc (1 line)
      1 | { "a": [ 1, 2, 3 ], "b": true }

# format_selected empty object

    Code
      ts_tree_format(json)
    Output
      # jsonc (4 lines)
      1 | {
      2 |     "a": {},
      3 |     "b": true
      4 | }

# format_selected drop comments in compact, oneline modes

    Code
      json
    Output
      # jsonc (4 lines)
      1 | { // comment
      2 |   "a": // comment
      3 |     null
      4 | }
    Code
      ts_tree_format(json, options = list(format = "compact"))
    Output
      # jsonc (1 line)
      1 | {"a":null}
    Code
      ts_tree_format(json, options = list(format = "oneline"))
    Output
      # jsonc (1 line)
      1 | { "a": null }

# format_selected comments before commas in array

    Code
      json
    Output
      # jsonc (6 lines)
      1 | [
      2 |   1
      3 | // comment
      4 | // comment2
      5 | ,  2
      6 | ]
    Code
      ts_tree_format(json, options = list(format = "pretty"))
    Output
      # jsonc (7 lines)
      1 | [
      2 |     1
      3 |     // comment
      4 |     // comment2
      5 |     ,
      6 |     2
      7 | ]

