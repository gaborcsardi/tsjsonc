test_that("ts_tree_update", {
  json <- ts_tree_read_jsonc(text = "{ \"a\": true, \"b\": [1, 2, 3] }")
  expect_snapshot({
    json |> ts_tree_select("a") |> ts_tree_update(list("new", "element"))
  })
})

test_that("ts_tree_update with empty selection can be an insert", {
  json <- ts_tree_read_jsonc(text = "{ \"a\": true, \"b\": [1, 2, 3] }")
  expect_snapshot({
    upd <- json |>
      ts_tree_select("new", "element") |>
      ts_tree_update(list("new", "value"), options = list(format = "pretty"))
    print(upd, n = Inf)
  })
})

test_that("updated_selected with empry non-character selection is noop", {
  json <- ts_tree_read_jsonc(text = "{ \"a\": true, \"b\": [1, 2, 3] }")
  expect_snapshot({
    upd <- json |>
      ts_tree_select("b", 10) |>
      ts_tree_update(list("new", "value"))
    print(upd, n = Inf)
  })
})
