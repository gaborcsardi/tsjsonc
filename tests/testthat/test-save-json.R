test_that("save_json", {
  json <- ts_tree_read_jsonc(
    text = ts_serialize_jsonc(list(a = list(1, 2, 3), b = list(b1 = "foo")))
  )

  tmpdir <- tempfile()
  on.exit(unlink(tmpdir, recursive = TRUE), add = TRUE)
  mkdirp(tmpdir)
  tmp <- file.path(tmpdir, "test.json")
  ts_tree_write(json, file = tmp)

  expect_snapshot({
    ts_tree_read_jsonc(tmp)
  })

  expect_snapshot(error = TRUE, {
    ts_tree_write(json)
  })

  ts_tree_write(ts_tree_delete(ts_tree_select(
    ts_tree_read_jsonc(tmp),
    "a"
  )))
  expect_snapshot({
    ts_tree_read_jsonc(tmp)
  })

  expect_snapshot({
    ts_tree_write(json, file = stdout())
  })

  tmp2 <- file.path(tmpdir, "bin.json")
  out <- file(tmp2, open = "wb")
  on.exit(try(close(out), silent = TRUE), add = TRUE)
  ts_tree_write(json, file = out)
  close(out)
  expect_snapshot({
    ts_tree_read_jsonc(tmp2)
  })
})
