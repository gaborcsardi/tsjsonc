test_that("can modify objects by name", {
  expect_snapshot(
    parse_json(text = "{}") |>
      select("foo") |>
      update_selected(1)
  )
  expect_snapshot(
    parse_json(text = "{}") |>
      select("foo") |>
      update_selected(1:2)
  )
  expect_snapshot(
    parse_json(text = "{}") |>
      select("foo") |>
      update_selected(list(1, "x"))
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
    parse_json(text = text) |> select("foo") |> update_selected(0)
  )

  expect_snapshot(
    parse_json(text = text) |> select("bar", 2) |> update_selected(0)
  )

  expect_snapshot(
    print(
      parse_json(text = text) |>
        select("bar") |>
        insert_into_selected(0, at = 2),
      n = 20
    )
  )

  expect_snapshot(
    print(
      parse_json(text = text) |> select("new") |> update_selected(0),
      n = 20
    )
  )
})

test_that("can't modify non-object non-array parents", {
  expect_snapshot(error = TRUE, {
    parse_json(text = "1") |> select("foo") |> update_selected(0)
  })
  expect_snapshot(error = TRUE, {
    parse_json(text = '"a"') |> select("foo") |> update_selected(0)
  })
  expect_snapshot(error = TRUE, {
    parse_json(text = "true") |> select("foo") |> update_selected(0)
  })
  expect_snapshot(error = TRUE, {
    parse_json(text = "null") |> select("foo") |> update_selected(0)
  })
})
