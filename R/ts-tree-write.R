#' @ts ts_tree_write_details_file
#'
#' Format a JSONC file:
#'
#' ```{r}
#' #| eval = FALSE
#' tree <- tsjsonc::ts_read_jsonc("config.json")
#' tree |> ts_tree_format() |> ts_tree_write()
#' ```
#'
#' @export

ts_tree_write.ts_tree_jsonc <- function(tree, file = NULL) {
  NextMethod()
}
