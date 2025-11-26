test_that("ts_tree_insert", {
  json <- ts_tree_read_jsonc(text = "{ \"a\": true, \"b\": [1, 2, 3] }")
  expect_snapshot({
    json |>
      ts_tree_select("b") |>
      ts_tree_insert("foo", at = 1, options = list(format = "auto"))
  })
})

test_that("ts_tree_insert with empty selection", {
  json <- ts_tree_read_jsonc(text = "{ \"a\": true, \"b\": [1, 2, 3] }")
  expect_snapshot({
    json |>
      ts_tree_select("new") |>
      ts_tree_insert("foo", options = list(format = "auto"))
  })
})

test_that("ts_tree_insert multi-line array is pretty", {
  json <- ts_tree_read_jsonc(
    text = "{ \"a\": true, \"b\": [\n  1,\n  2,\n  3\n] }"
  )
  expect_snapshot({
    json |>
      ts_tree_select("b") |>
      ts_tree_insert(list(a = 1, b = 2), options = list(format = "auto"))
  })
})

test_that("ts_tree_insert with compact array is compact", {
  json <- ts_tree_read_jsonc(text = "{ \"a\":true, \"b\":[1,2,3] }")
  expect_snapshot({
    json |>
      ts_tree_select("b") |>
      ts_tree_insert(list(1, 2), options = list(format = "auto"))
  })
})

test_that("ts_tree_insert document", {
  json <- ts_tree_read_jsonc(text = "")
  expect_snapshot({
    json |>
      ts_tree_insert(list(a = 1, b = 2), options = list(format = "auto"))
  })
})

test_that("ts_tree_insert object", {
  json <- ts_tree_read_jsonc(text = "{ \"a\": { } }")
  expect_snapshot({
    json |>
      ts_tree_select("a") |>
      ts_tree_insert(42, key = "b", options = list(format = "auto"))
  })
  json <- ts_tree_read_jsonc(text = "{ \"a\": { \"b\": 42 } }")
  expect_snapshot({
    json |>
      ts_tree_select("a") |>
      ts_tree_insert(43, key = "c", options = list(format = "auto"))
  })
})

test_that("ts_tree_insert force formatting", {
  json <- ts_tree_read_jsonc(text = "{ \"a\":true, \"b\":[1,2,3] }")
  expect_snapshot({
    json |>
      ts_tree_select("b") |>
      ts_tree_insert(list(1, 2), options = list(format = "pretty"))
  })
})

test_that("insert_into_document errors", {
  json <- ts_tree_read_jsonc(text = "{ \"a\":true, \"b\":[1,2,3] }")
  expect_snapshot(error = TRUE, {
    json |> insert_into_document("true", "pretty")
  })
})

test_that("ts_tree_insert adds newline if needed", {
  json <- ts_tree_read_jsonc(text = "// comment")
  expect_snapshot({
    json |>
      ts_tree_insert(list(a = 1, b = 2), options = list(format = "auto"))
  })
  json <- ts_tree_read_jsonc(text = "// comment\n// comment2")
  expect_snapshot({
    json |>
      ts_tree_insert(list(a = 1, b = 2), options = list(format = "auto"))
  })
})

test_that("ts_tree_insert invalid index", {
  json <- ts_tree_read_jsonc(text = "{ \"a\": true, \"b\": [1, 2, 3] }")
  expect_snapshot(error = TRUE, {
    json |>
      ts_tree_select("b") |>
      ts_tree_insert("foo", at = "bar", options = list(format = "auto"))
  })
})

test_that("ts_tree_insert insert into empty array", {
  json <- ts_tree_read_jsonc(text = "{ \"a\": true, \"b\": [] }")
  expect_snapshot({
    json |>
      ts_tree_select("b") |>
      ts_tree_insert("foo", options = list(format = "auto"))
  })
})

test_that("ts_tree_insert insert at beginning of array", {
  json <- ts_tree_read_jsonc(text = "{ \"a\": true, \"b\": [1] }")
  expect_snapshot({
    json |>
      ts_tree_select("b") |>
      ts_tree_insert("foo", at = 0, options = list(format = "auto"))
  })
})

test_that("ts_tree_insert insert into object by key", {
  json <- ts_tree_read_jsonc(text = "{ \"a\": true, \"b\": [1] }")
  expect_snapshot({
    json |>
      ts_tree_insert(
        "val",
        key = "key",
        at = "a",
        options = list(format = "auto")
      )
  })
})

test_that("ts_tree_insert insert into object by non-existing key", {
  json <- ts_tree_read_jsonc(text = "{ \"a\": true, \"b\": [1] }")
  expect_snapshot({
    json |>
      ts_tree_insert(
        "val",
        key = "key",
        at = "nope",
        options = list(format = "auto")
      )
  })
})

test_that("ts_tree_insert insert into object at be beginning", {
  json <- ts_tree_read_jsonc(text = "{ \"a\": true, \"b\": [1] }")
  expect_snapshot({
    json |>
      ts_tree_insert(
        "val",
        key = "key",
        at = 0,
        options = list(format = "auto")
      )
  })
})

test_that("insert_into_array, comment is kept on same line", {
  json <- ts_tree_read_jsonc(text = '{ "a": [1, 2 // comment\n]\n}')
  expect_snapshot({
    json
    json |> ts_tree_select("a") |> ts_tree_insert(42, at = Inf)
    json |> ts_tree_select("a") |> ts_tree_insert(42, at = 2)
  })
})

test_that("insert_into_array, multiple comments before comma", {
  json <- ts_tree_read_jsonc(
    text = '{ "a": [1\n// comment1\n// comment2\n, 2]\n}'
  )
  expect_snapshot({
    json
    json |> ts_tree_select("a") |> ts_tree_insert(42, at = 1)
  })
})

test_that("insert_into_object, comment is kept on same line", {
  json <- ts_tree_read_jsonc(text = '{ "a": 1, // comment\n  "b": 2\n}')
  expect_snapshot({
    json
    json |> ts_tree_insert(42, key = "x", at = "a")
  })
})

test_that("insert_into_object, multiple comments before comma", {
  json <- ts_tree_read_jsonc(
    text = '{ "a": 1\n// comment1\n// comment2\n, "b": 2\n}'
  )
  expect_snapshot({
    json
    json |> ts_tree_insert(42, at = "a", key = "x")
  })
})

test_that("insert_into_array, trailing comma and appending", {
  json <- ts_tree_read_jsonc(text = "[1,2,3,//comment\n]")
  expect_snapshot({
    json
    json |> ts_tree_insert(4)
  })
})

test_that("insert_into_object, trailing comma and appending", {
  json <- ts_tree_read_jsonc(
    text = "{ \"a\": 1, \"b\": 2, \"c\": 3, // comment\n}"
  )
  expect_snapshot({
    json
    json |> ts_tree_insert(key = "d", 4)
  })
})
