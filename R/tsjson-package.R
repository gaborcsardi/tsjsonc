#' @keywords internal
"_PACKAGE"

#' @importFrom utils head tail
#' @import ts
NULL

#' @name quickstart
#' @title tsjson quickstart
#' @details
#'
#' ```{r, child = "tools/man/quickstart.Rmd"}
#' ```
NULL

## usethis namespace: start
#' @useDynLib tsjson, .registration = TRUE, .fixes = "c_"
## usethis namespace: end
NULL

ts_language_json <- function() {
  .Call(c_ts_language_json)
}
