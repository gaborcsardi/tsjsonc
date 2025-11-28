#' @keywords internal
"_PACKAGE"

#' @importFrom utils head tail
#' @import ts
# #' @export ts_tree_ast
# #' @export ts_tree_delete
# #' @export ts_tree_deleted
# #' @export ts_tree_dom
# #' @export ts_tree_format
# #' @export ts_tree_insert
# #' @export ts_tree_query
# #' @export ts_tree_select
# #' @export ts_tree_select<-
# #' @export ts_tree_select_query
# #' @export ts_tree_sexpr
# #' @export ts_tree_unserialize
# #' @export ts_tree_update
# #' @export ts_tree_write
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

ts_language_jsonc <- function() {
  .Call(c_ts_language_jsonc)
}
