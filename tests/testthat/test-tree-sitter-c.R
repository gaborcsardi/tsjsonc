test_that("get_language error", {
  expect_snapshot(error = TRUE, {
    .Call(c_s_expr, "input", 1L, NULL)
  })
})

test_that("token_table", {
  text <- "{ \"a\": true, \"b\": [1, 2, 3] }"
  badranges2 <- data.frame(
    start_row = c(1L, 1L),
    start_col = c(1L, 11L),
    end_row = c(1L, 1L),
    end_col = c(15L, nchar(text)),
    start_byte = c(1L, 11L),
    end_byte = c(15L, nchar(text))
  )
  expect_snapshot(error = TRUE, {
    token_table(text = text, ranges = badranges2)
  })
})

test_that("check_predicate_eq", {
  testthat::local_reproducible_output(width = 500)
  text <- "{ \"a\": 1, \"b\": \"foo\", \"c\": 20 }"
  expect_snapshot({
    query_json(
      text = text,
      query = "((pair key: (string (string_content) @key) (#eq? @key \"a\")))"
    )
  })
})

test_that("check_predicate_eq 2", {
  testthat::local_reproducible_output(width = 500)
  text <- "{ \"a\": 1, \"b\": \"foo\", \"x\": \"x\", \"c\": 20 }"
  expect_snapshot({
    query_json(
      text = text,
      query = "((pair key: (string (string_content) @key)
                 value: (string (string_content) @val)
                 (#eq? @key @val)
               ))"
    )
  })
})

test_that("parse error", {
  text <- "[,1,2,3]"
  expect_snapshot(error = TRUE, unserialize_json(text = text))
})
