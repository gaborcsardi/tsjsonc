#' @keywords internal
"_PACKAGE"

#' @importFrom utils head tail
#' @import ts
NULL

#' @name quickstart
#' @title tsjsonc quickstart
#' @details
#'
#' ```{r, child = "tools/man/quickstart.Rmd"}
#' ```
NULL

## usethis namespace: start
#' @useDynLib tsjsonc, .registration = TRUE, .fixes = "c_"
## usethis namespace: end
NULL

#' Tree sitter language object for JSONC
#'
#' Use this function with [ts::ts_tree_new()] to create a tree-sitter
#' tree for a JSONC document.
#' @export

ts_language_jsonc <- function() {
  .Call(c_ts_language_jsonc)
}
