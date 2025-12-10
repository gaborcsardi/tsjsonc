test_that("ts_format_jsonc", {
  text <- ts_serialize_jsonc(
    options = list(format = "compact"),
    list(
      a = 1,
      b = list(b1 = 21, b2 = 22),
      c = 3,
      d = list(1, 2, 3)
    )
  )
  tmp <- tempfile(fileext = ".jsonc")
  on.exit(unlink(tmp), add = TRUE)
  writeLines(text, tmp)

  expect_snapshot({
    ts_format_jsonc(file = tmp)
    writeLines(readLines(tmp))
  })
})
