test_that("ts_serialize_jsonc", {
  expect_snapshot({
    ts_serialize_jsonc(NULL)
    ts_serialize_jsonc(TRUE)
    ts_serialize_jsonc(FALSE)
    ts_serialize_jsonc(1L)
    ts_serialize_jsonc(1.1)
    ts_serialize_jsonc(.25)
  })

  expect_snapshot({
    ts_serialize_jsonc(list())
    writeLines(ts_serialize_jsonc(list(1)))
    writeLines(ts_serialize_jsonc(list(1, 2, 3)))
    writeLines(ts_serialize_jsonc(list(1, list(21, 22), 3)))
    writeLines(ts_serialize_jsonc(list(1, list(a = 1, b = 2), 3)))
  })

  expect_snapshot({
    writeLines(ts_serialize_jsonc(structure(list(), names = character())))
    writeLines(ts_serialize_jsonc(list(a = 1)))
    writeLines(ts_serialize_jsonc(list(a = 1, b = 2, c = 3)))
    writeLines(ts_serialize_jsonc(list(a = 1, b = list(21, 22), c = 3)))
    writeLines(ts_serialize_jsonc(list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3
    )))
  })
})

test_that("ts_serialize_jsonc collapse", {
  expect_snapshot({
    (txt <- ts_serialize_jsonc(list(a = 1, b = 2), collapse = TRUE))
    writeLines(txt)
  })
})

test_that("ts_serialize_jsonc format", {
  expect_snapshot({
    writeLines(ts_serialize_jsonc(
      list(1, 2, 3),
      options = list(format = "compact")
    ))
    writeLines(ts_serialize_jsonc(
      list(a = 1, b = 2),
      options = list(format = "compact")
    ))
  })

  expect_snapshot({
    writeLines(ts_serialize_jsonc(
      list(1, 2, 3),
      options = list(format = "oneline")
    ))
    writeLines(ts_serialize_jsonc(
      list(a = 1, b = 2),
      options = list(format = "oneline")
    ))
  })
})

test_that("ts_serialize_jsonc file", {
  tmp <- tempfile(fileext = ".json")
  on.exit(unlink(tmp), add = TRUE)
  ts_serialize_jsonc(list(a = 1, b = list(b1 = 21, b2 = 22), c = 3), file = tmp)
  expect_snapshot({
    writeLines(readLines(tmp))
  })
})
