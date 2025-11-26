test_that("print.tsjsonc", {
  json <- ts_tree_read_jsonc(
    text = ts_serialize_jsonc(list(a = list(1, 2, 3), b = list(b1 = "foo")))
  )
  expect_snapshot(json)
})

test_that("format_ts_tree_noselection", {
  json <- ts_tree_read_jsonc(
    text = ts_serialize_jsonc(list(a = list(1, 2, 3), b = list(b1 = "foo")))
  )
  expect_snapshot({
    ts_tree_select(json, "no-such-element")
  })
})

test_that("format_ts_tree_noselection long document", {
  json <- ts_tree_read_jsonc(
    text = ts_serialize_jsonc(list(a = as.list(letters)))
  )
  expect_snapshot({
    json
  })
})

test_that("format_ts_tree_selection", {
  json <- ts_tree_read_jsonc(
    text = ts_serialize_jsonc(list(a = list(1, 2, 3), b = list(b1 = "foo")))
  )
  expect_snapshot({
    ts_tree_select(json, "a")
    ts_tree_select(json, "a", 1:2)
    ts_tree_select(json, "b", "b1")
  })
})

test_that("many selections", {
  json <- ts_tree_read_jsonc(
    text = ts_serialize_jsonc(list(a = as.list(1:100)))
  )
  expect_snapshot({
    ts_tree_select(json, "a", seq(2, 30, by = 2))
  })
})

test_that("plural", {
  expect_snapshot({
    plural(1)
    plural(2)
    plural(0)
    plural(100)
  })
})
