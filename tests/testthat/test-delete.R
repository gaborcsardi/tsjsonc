test_that("ts_tree_delete comment is deleted", {
  json <- ts_parse_jsonc(
    text = "{ \"a\": //comment\ntrue, \"b\": [1, 2, 3] }"
  )
  expect_snapshot({
    json |> ts_tree_select("a") |> ts_tree_delete()
  })
})

test_that("ts_tree_delete comment is preserved", {
  json <- ts_parse_jsonc(
    text = "{ \"a\": true, \"b\": [1, 2, 3]\n//comment\n}"
  )
  expect_snapshot({
    json |> ts_tree_select("a") |> ts_tree_delete()
  })
})

test_that("ts_tree_delete nothing to delete", {
  json <- ts_parse_jsonc(text = "{ \"a\": true, \"b\": [1, 2, 3] }")
  expect_snapshot({
    json |> ts_tree_select("c") |> ts_tree_delete()
  })
})

test_that("ts_tree_delete all elements from an array", {
  json <- ts_parse_jsonc(text = "{ \"a\": true, \"b\": [1] }")
  expect_snapshot({
    json |> ts_tree_select("b", 1) |> ts_tree_delete()
  })
})

test_that("ts_tree_delete first elements from an array", {
  json <- ts_parse_jsonc(text = "{ \"a\": true, \"b\": [1, 2, 3] }")
  expect_snapshot({
    json |> ts_tree_select("b", 1:2) |> ts_tree_delete()
  })
})

test_that("ts_tree_delete middle of an array", {
  json <- ts_parse_jsonc(text = "{ \"a\": true, \"b\": [1, 2, 3, 4] }")
  expect_snapshot({
    json |> ts_tree_select("b", 2:3) |> ts_tree_delete()
  })
})

test_that("ts_tree_delete last elements of an array", {
  json <- ts_parse_jsonc(text = "{ \"a\": true, \"b\": [1, 2, 3, 4] }")
  expect_snapshot({
    json |> ts_tree_select("b", 3:4) |> ts_tree_delete()
  })
})

test_that("ts_tree_delete whitespace of last element is kept", {
  json <- ts_parse_jsonc(text = "{ \"a\": true, \"b\": [1, 2, 3, 4] \n }")
  expect_snapshot({
    json |> ts_tree_select("b") |> ts_tree_delete()
  })
})
