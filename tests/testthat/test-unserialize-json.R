test_that("ts_tree_unserialize", {
  json <- ts_parse_jsonc(text = '{ "a": 1, "b": [1, 2, 3] }')
  expect_snapshot({
    json |> ts_tree_unserialize()
  })
})

test_that("ts_tree_unserialize", {
  json <- ts_parse_jsonc(text = '{ "a": false, "b": [1, 2, 3] }')
  expect_snapshot({
    json |> ts_tree_select("a") |> ts_tree_unserialize()
  })
})
