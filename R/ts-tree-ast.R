#' @ts ts_tree_ast_details_syntax_vs_dom
#'
#' ```{asciicast}
#' #| results = "hide"
#' tree <- ts_parse_jsonc("{ \"a\": true, \"b\": [1, 2, 3] }")
#' ```
#'
#' ```{asciicast}
#' ts_tree_ast(tree)
#' ```
#'
#' ```{asciicast}
#' ts_tree_dom(tree)
#' ```
#'
#' @export

ts_tree_ast.ts_tree_jsonc <- function(tree) {
  NextMethod()
}
