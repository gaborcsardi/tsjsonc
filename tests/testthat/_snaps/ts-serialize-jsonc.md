# ts_serialize_jsonc

    Code
      ts_serialize_jsonc(NULL)
    Output
      [1] "null"
    Code
      ts_serialize_jsonc(TRUE)
    Output
      [1] "true"
    Code
      ts_serialize_jsonc(FALSE)
    Output
      [1] "false"
    Code
      ts_serialize_jsonc(1L)
    Output
      [1] "1"
    Code
      ts_serialize_jsonc(1.1)
    Output
      [1] "1.1"
    Code
      ts_serialize_jsonc(0.25)
    Output
      [1] "0.25"

---

    Code
      ts_serialize_jsonc(list())
    Output
      [1] "[]"
    Code
      writeLines(ts_serialize_jsonc(list(1)))
    Output
      [
        1
      ]
    Code
      writeLines(ts_serialize_jsonc(list(1, 2, 3)))
    Output
      [
        1,
        2,
        3
      ]
    Code
      writeLines(ts_serialize_jsonc(list(1, list(21, 22), 3)))
    Output
      [
        1,
        [
          21,
          22
        ],
        3
      ]
    Code
      writeLines(ts_serialize_jsonc(list(1, list(a = 1, b = 2), 3)))
    Output
      [
        1,
        {
          "a": 1,
          "b": 2
        },
        3
      ]

---

    Code
      writeLines(ts_serialize_jsonc(structure(list(), names = character())))
    Output
      {}
    Code
      writeLines(ts_serialize_jsonc(list(a = 1)))
    Output
      {
        "a": 1
      }
    Code
      writeLines(ts_serialize_jsonc(list(a = 1, b = 2, c = 3)))
    Output
      {
        "a": 1,
        "b": 2,
        "c": 3
      }
    Code
      writeLines(ts_serialize_jsonc(list(a = 1, b = list(21, 22), c = 3)))
    Output
      {
        "a": 1,
        "b": [
          21,
          22
        ],
        "c": 3
      }
    Code
      writeLines(ts_serialize_jsonc(list(a = 1, b = list(b1 = 21, b2 = 22), c = 3)))
    Output
      {
        "a": 1,
        "b": {
          "b1": 21,
          "b2": 22
        },
        "c": 3
      }

# ts_serialize_jsonc collapse

    Code
      (txt <- ts_serialize_jsonc(list(a = 1, b = 2), collapse = TRUE))
    Output
      [1] "{\n  \"a\": 1,\n  \"b\": 2\n}"
    Code
      writeLines(txt)
    Output
      {
        "a": 1,
        "b": 2
      }

# ts_serialize_jsonc format

    Code
      writeLines(ts_serialize_jsonc(list(1, 2, 3), options = list(format = "compact")))
    Output
      [1,2,3]
    Code
      writeLines(ts_serialize_jsonc(list(a = 1, b = 2), options = list(format = "compact")))
    Output
      {"a":1,"b":2}

---

    Code
      writeLines(ts_serialize_jsonc(list(1, 2, 3), options = list(format = "oneline")))
    Output
      [ 1, 2, 3 ]
    Code
      writeLines(ts_serialize_jsonc(list(a = 1, b = 2), options = list(format = "oneline")))
    Output
      { "a": 1, "b": 2 }

# ts_serialize_jsonc file

    Code
      writeLines(readLines(tmp))
    Output
      {
        "a": 1,
        "b": {
          "b1": 21,
          "b2": 22
        },
        "c": 3
      }

