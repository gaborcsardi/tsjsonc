test_that("unserialize_selected", {
  json <- parse_json(text = '{ "a": 1, "b": [1, 2, 3] }')
  expect_snapshot({
    json |> unserialize_selected()
  })
})

test_that("unserialize_false", {
  json <- parse_json(text = '{ "a": false, "b": [1, 2, 3] }')
  expect_snapshot({
    json |> select("a") |> unserialize_selected()
  })
})
