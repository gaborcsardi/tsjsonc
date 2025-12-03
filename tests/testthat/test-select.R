test_that("ts_tree_selection, ts_tree_selected_nodes", {
  json <- ts_parse_jsonc(text = "")
  expect_snapshot({
    ts_tree_selection(json)
    ts_tree_selection(json, default = FALSE)
    ts_tree_selected_nodes(json)
    ts_tree_selected_nodes(json, default = FALSE)
  })

  json <- ts_parse_jsonc(text = "[]")
  expect_snapshot({
    ts_tree_selection(json)
    ts_tree_selection(json, default = FALSE)
    ts_tree_selected_nodes(json)
    ts_tree_selected_nodes(json, default = FALSE)
  })
})

test_that("ts_tree_select", {
  json <- ts_parse_jsonc(
    text = ts_serialize_jsonc(list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3,
      d = list(1, 2, 3)
    ))
  )
  expect_snapshot({
    ts_tree_select(json)
    ts_tree_select(json, "a")
    ts_tree_select(json, c("a", "b"))
    ts_tree_select(json, "b", "b1")
    ts_tree_select(json, list("b", "b1"))
    ts_tree_select(json, "d", 1)
    ts_tree_select(json, "d", TRUE)
  })

  expect_snapshot(error = TRUE, {
    ts_tree_select(json, raw(0))
  })
})

test_that("deselect with NULL", {
  json <- ts_parse_jsonc(
    text = ts_serialize_jsonc(list(a = 1, c = 3))
  )
  expect_snapshot({
    ts_tree_select(json, "a")
    ts_tree_select(ts_tree_select(json, "a"), NULL)
  })
})

test_that("[[.tdjson", {
  json <- ts_parse_jsonc(
    text = ts_serialize_jsonc(list(
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

test_that("[[<-.tsjsonc", {
  json <- ts_parse_jsonc(
    text = ts_serialize_jsonc(list(
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

test_that("[[<-.tsjsonc empty doc", {
  json <- ts_parse_jsonc(text = "")
  json[[]] <- list()
  expect_snapshot(json)

  json <- ts_parse_jsonc(text = "")
  json[[]] <- structure(list(), names = character())
  expect_snapshot(json)
})

test_that("[[<-.tsjsonc deletion", {
  json <- ts_parse_jsonc(
    text = ts_serialize_jsonc(list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3,
      d = list(1, 2, 3)
    ))
  )

  expect_snapshot({
    json[[c("a", "b")]] <- ts_tree_deleted()
    json
  })
})

test_that("select regex", {
  json <- ts_parse_jsonc(
    text = ts_serialize_jsonc(list(
      a1 = 1,
      a2 = list(b1 = 21, b2 = 22),
      c = 3,
      a3 = list(1, 2, 3)
    ))
  )

  # TODO
  expect_snapshot({
    json[[c(regex = "^a")]]
  })

  # regex in array selects nothing
  json2 <- ts_parse_jsonc(
    text = ts_serialize_jsonc(list(1, 2, 3))
  )
  expect_snapshot(
    json2[[c(regex = ".")]]
  )
})

test_that("select from the back", {
  json <- ts_parse_jsonc(
    text = ts_serialize_jsonc(list(
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

test_that("select I()", {
  json <- ts_parse_jsonc(
    text = ts_serialize_jsonc(list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3,
      d = list(1, 2, 3)
    ))
  )

  expect_snapshot({
    json[[I(26)]]
  })
})

test_that("ts_tree_select<-", {
  json <- ts_parse_jsonc(
    text = ts_serialize_jsonc(list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3,
      d = list(1, 2, 3)
    ))
  )

  expect_snapshot({
    ts_tree_select(json, "a") <- 2
    json
  })

  expect_snapshot({
    ts_tree_select(json, c("a")) <- ts_tree_deleted()
    json
  })

  expect_snapshot({
    ts_tree_select(json, list("b", "b1")) <- 100
    json
  })
})

test_that("[[<-.tsjsonc", {
  json <- ts_parse_jsonc(
    text = ts_serialize_jsonc(list(
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
  json <- ts_parse_jsonc(
    text = ts_serialize_jsonc(list(
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
  json <- ts_parse_jsonc(
    text = ts_serialize_jsonc(list(
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

test_that("ts_tree_select_query", {
  txt <- "{ \"a\": 1, \"b\": \"foo\", \"c\": 20 }"

  # Select all pairs where the value is a number and change them to 100
  expect_snapshot({
    ts_parse_jsonc(text = txt) |>
      ts_tree_select_query("((pair value: (number) @num))") |>
      ts_tree_update(100)
  })
})
