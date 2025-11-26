test_that("can modify objects by name", {
  expect_snapshot(
    ts_tree_read_jsonc(text = "{}") |>
      ts_tree_select("foo") |>
      ts_tree_update(1)
  )
  expect_snapshot(
    ts_tree_read_jsonc(text = "{}") |>
      ts_tree_select("foo") |>
      ts_tree_update(1:2)
  )
  expect_snapshot(
    ts_tree_read_jsonc(text = "{}") |>
      ts_tree_select("foo") |>
      ts_tree_update(list(1, "x"))
  )
})

test_that("modification retains comments", {
  text <- '
{
    // a
    "foo": 1, // b
    "bar": [
        // c
        1,
        2, // d
        // e
        3
    ] // f
    // g
}
  '

  expect_snapshot(
    ts_tree_read_jsonc(text = text) |>
      ts_tree_select("foo") |>
      ts_tree_update(0)
  )

  expect_snapshot(
    ts_tree_read_jsonc(text = text) |>
      ts_tree_select("bar", 2) |>
      ts_tree_update(0)
  )

  expect_snapshot(
    print(
      ts_tree_read_jsonc(text = text) |>
        ts_tree_select("bar") |>
        ts_tree_insert(0, at = 2),
      n = 20
    )
  )

  expect_snapshot(
    print(
      ts_tree_read_jsonc(text = text) |>
        ts_tree_select("new") |>
        ts_tree_update(0),
      n = 20
    )
  )
})

test_that("can't modify non-object non-array parents", {
  expect_snapshot(error = TRUE, {
    ts_tree_read_jsonc(text = "1") |> ts_tree_select("foo") |> ts_tree_update(0)
  })
  expect_snapshot(error = TRUE, {
    ts_tree_read_jsonc(text = '"a"') |>
      ts_tree_select("foo") |>
      ts_tree_update(0)
  })
  expect_snapshot(error = TRUE, {
    ts_tree_read_jsonc(text = "true") |>
      ts_tree_select("foo") |>
      ts_tree_update(0)
  })
  expect_snapshot(error = TRUE, {
    ts_tree_read_jsonc(text = "null") |>
      ts_tree_select("foo") |>
      ts_tree_update(0)
  })
})
