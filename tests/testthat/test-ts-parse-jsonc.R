test_that("ts_parse_jsonc", {
  testthat::local_reproducible_output(width = 500)
  json <- ts_parse_jsonc(text = "")
  expect_snapshot(json)

  json <- ts_parse_jsonc(text = "[]")
  expect_snapshot(json)

  json <- ts_parse_jsonc(text = "// comment\n[1,2,3]")
  expect_snapshot({
    json
    json[]
  })

  # from file
  tmpdir <- tempfile()
  on.exit(unlink(tmpdir, recursive = TRUE), add = TRUE)
  mkdirp(tmpdir)
  tmp <- file.path(tmpdir, "three.json")
  writeLines(c("// comment", "[1,2,3]"), tmp)
  json <- ts_read_jsonc(tmp)
  expect_snapshot({
    json
  })

  # leading whitespace
  json <- ts_parse_jsonc(text = "\n\n   [1,2,3]\n")
  expect_snapshot({
    json
    json[]
  })
})

test_that("ts_parse_jsonc with options", {
  testthat::local_reproducible_output(width = 500)
  json <- ts_parse_jsonc(
    text = "// comment\n{ \"a\": 1 }",
    options = list(allow_comments = TRUE)
  )
  expect_snapshot({
    json
  })
})

test_that("ts_read_jsonc errors", {
  expect_snapshot(error = TRUE, {
    ts_tree_new(ts_language_jsonc())
    ts_tree_new(ts_language_jsonc(), file = tempfile(), text = "foo")
  })
})

test_that("[.tsjsonc", {
  # tested above
  expect_true(TRUE)
})
