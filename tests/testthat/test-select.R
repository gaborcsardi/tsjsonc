test_that("get_selection, get_selected_nodes", {
  json <- parse_json(text = "")
  expect_snapshot({
    get_selection(json)
    get_selection(json, default = FALSE)
    get_selected_nodes(json)
    get_selected_nodes(json, default = FALSE)
  })

  json <- parse_json(text = "[]")
  expect_snapshot({
    get_selection(json)
    get_selection(json, default = FALSE)
    get_selected_nodes(json)
    get_selected_nodes(json, default = FALSE)
  })
})

test_that("ts_select", {
  json <- parse_json(
    text = serialize_json(list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3,
      d = list(1, 2, 3)
    ))
  )
  expect_snapshot({
    ts_select(json)
    ts_select(json, "a")
    ts_select(json, c("a", "b"))
    ts_select(json, "b", "b1")
    ts_select(json, list("b", "b1"))
    ts_select(json, "d", 1)
    ts_select(json, "d", TRUE)
  })

  expect_snapshot(error = TRUE, {
    ts_select(json, raw(0))
  })
})

test_that("deselect with NULL", {
  json <- parse_json(
    text = serialize_json(list(a = 1, c = 3))
  )
  expect_snapshot({
    ts_select(json, "a")
    ts_select(ts_select(json, "a"), NULL)
  })
})

test_that("[[.tdjson", {
  json <- parse_json(
    text = serialize_json(list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3,
      d = list(1, 2, 3)
    ))
  )

  expect_snapshot({
    json[[]]
    json[["a"]]
    json[[c("a", "b")]]
    json[["b", "b1"]]
    json[[list("b", "b1")]]
    json[["d", 1]]
    json[["d", TRUE]]
  })

  expect_snapshot({
    json[["d"]][["nothing"]]
  })
})

test_that("[[<-.tsjson", {
  json <- parse_json(
    text = serialize_json(list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3,
      d = list(1, 2, 3)
    ))
  )

  expect_snapshot({
    json[["a"]] <- 2
    json
  })

  expect_snapshot({
    json[[c("a", "c")]] <- TRUE
    json
  })

  expect_snapshot({
    json[[list("b", "b1")]] <- 100
    json
  })
})

test_that("[[<-.tsjson empty doc", {
  json <- parse_json(text = "")
  json[[]] <- list()
  expect_snapshot(json)

  json <- parse_json(text = "")
  json[[]] <- structure(list(), names = character())
  expect_snapshot(json)
})

test_that("[[<-.tsjson deletion", {
  json <- parse_json(
    text = serialize_json(list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3,
      d = list(1, 2, 3)
    ))
  )

  expect_snapshot({
    json[[c("a", "b")]] <- ts::ts_deleted()
    json
  })
})

test_that("select regex", {
  json <- parse_json(
    text = serialize_json(list(
      a1 = 1,
      a2 = list(b1 = 21, b2 = 22),
      c = 3,
      a3 = list(1, 2, 3)
    ))
  )

  expect_snapshot({
    json[[c(regex = "^a")]]
  })

  # regex in array selects nothing
  json2 <- parse_json(
    text = serialize_json(list(1, 2, 3))
  )
  expect_snapshot(
    json2[[c(regex = ".")]]
  )
})

test_that("select from the back", {
  json <- parse_json(
    text = serialize_json(list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3,
      d = list(1, 2, 3)
    ))
  )

  expect_snapshot({
    json[[-1, -2]]
    json[[-1, c(1, -2)]]
  })
})

test_that("ts::ts_selector_ids", {
  json <- parse_json(
    text = serialize_json(list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3,
      d = list(1, 2, 3)
    ))
  )

  expect_snapshot({
    json[[ts::ts_selector_ids(26)]]
  })
})

test_that("ts_select<-", {
  json <- parse_json(
    text = serialize_json(list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3,
      d = list(1, 2, 3)
    ))
  )

  expect_snapshot({
    ts_select(json, "a") <- 2
    json
  })

  expect_snapshot({
    ts_select(json, c("a")) <- ts::ts_deleted()
    json
  })

  expect_snapshot({
    ts_select(json, list("b", "b1")) <- 100
    json
  })
})

test_that("[[<-.tsjson", {
  json <- parse_json(
    text = serialize_json(list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3,
      d = list(1, 2, 3)
    ))
  )
  expect_snapshot({
    json[[list("b", "b1")]] <- 100
    json
  })
})

test_that("select character selector on array selects nothing", {
  json <- parse_json(
    text = serialize_json(list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3,
      d = list(1, 2, 3)
    ))
  )
  expect_snapshot({
    json[["d", "1"]]
    json[["d", "a"]]
  })
})

test_that("select zero indices error", {
  json <- parse_json(
    text = serialize_json(list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3,
      d = list(1, 2, 3)
    ))
  )
  expect_snapshot(error = TRUE, {
    json[[list("b", c(1, 2, 0, 3))]]
  })
})

test_that("ts_select_query", {
  txt <- "{ \"a\": 1, \"b\": \"foo\", \"c\": 20 }"

  # Select all pairs where the value is a number and change them to 100
  expect_snapshot({
    parse_json(text = txt) |>
      ts_select_query("((pair value: (number) @num))") |>
      update_selected(100)
  })
})
