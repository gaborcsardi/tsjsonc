test_that("ts_format_jsonc", {
  text <- ts_serialize_jsonc(
    options = list(format = "compact"),
    list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3,
      d = list(1, 2, 3)
    )
  )
  tmp <- tempfile(fileext = ".jsonc")
  on.exit(unlink(tmp), add = TRUE)
  writeLines(text, tmp)

  expect_snapshot({
    ts_format_jsonc(file = tmp)
    writeLines(readLines(tmp))
  })
})

test_that("format_selected", {
  text <- ts_serialize_jsonc(
    options = list(format = "compact"),
    list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3,
      d = list(1, 2, 3)
    )
  )
  json <- ts_parse_jsonc(text = text)

  expect_snapshot({
    ts_tree_format(json)
    ts_tree_format(ts_tree_select(json, "a"))
    ts_tree_format(ts_tree_select(json, "b"))
  })
  json <- ts_tree_format(json)
  expect_snapshot({
    ts_tree_format(ts_tree_select(json, "b"))
  })
})

test_that("format_selected null, true, false, string, comment", {
  text <- ts_serialize_jsonc(
    options = list(format = "compact"),
    list(
      a = NULL,
      b = TRUE,
      c = FALSE,
      d = list("a", "b", "c")
    )
  )
  json <- ts_parse_jsonc(text = text)
  expect_snapshot({
    ts_tree_format(json)
  })
  json <- ts_parse_jsonc(
    text = "{ // comment\n  \"a\": // comment\n    null\n}"
  )
  expect_snapshot({
    ts_tree_format(json)
  })
})

test_that("format_selected empty array", {
  text <- ts_serialize_jsonc(
    options = list(format = "compact"),
    list(
      a = list(),
      b = TRUE
    )
  )
  json <- ts_parse_jsonc(text = text)
  expect_snapshot({
    ts_tree_format(json)
  })
})

test_that("format_selected compact arrays", {
  text <- ts_serialize_jsonc(
    list(
      a = list(1, 2, 3),
      b = TRUE
    )
  )
  json <- ts_parse_jsonc(text = text)
  expect_snapshot({
    json
    ts_tree_format(json, options = list(format = "compact"))
  })
})

test_that("format_selected oneline arrays", {
  text <- ts_serialize_jsonc(
    list(
      a = list(1, 2, 3),
      b = TRUE
    )
  )
  json <- ts_parse_jsonc(text = text)
  expect_snapshot({
    json
    ts_tree_format(json, options = list(format = "oneline"))
  })
})

test_that("format_selected empty object", {
  text <- ts_serialize_jsonc(
    options = list(format = "compact"),
    list(
      a = structure(list(), names = character()),
      b = TRUE
    )
  )
  json <- ts_parse_jsonc(text = text)
  expect_snapshot({
    ts_tree_format(json)
  })
})

test_that("format_selected drop comments in compact, oneline modes", {
  json <- ts_parse_jsonc(
    text = "{ // comment\n  \"a\": // comment\n    null\n}"
  )
  expect_snapshot({
    json
    ts_tree_format(json, options = list(format = "compact"))
    ts_tree_format(json, options = list(format = "oneline"))
  })
})

test_that("format_selected comments before commas in array", {
  json <- ts_parse_jsonc(text = "[\n  1\n// comment\n// comment2\n,  2\n]")
  expect_snapshot({
    json
    ts_tree_format(json, options = list(format = "pretty"))
  })
})
