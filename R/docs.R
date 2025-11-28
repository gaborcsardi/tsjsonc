#' Show the annotated syntax tree of a JSONC tree-sitter tree
#'
#' `ts_tree_ast()` prints the annotated syntax tree of a tsjsonc object.
#' This syntax tree contains all tree-sitter nodes, and it shows the
#' source code associated with each node, along with line numbers.
#'
#' @details
#' ## The ts and tsjsonc packages:
#' [ts::ts_tree_ast()] is defined in the [ts package][ts::ts] and it is
#' re-exported from tsjsonc.
#'
#' ## The syntax tree and the DOM tree
#'
#' This syntax tree contains all nodes of the tree-sitter parse tree,
#' including both named and unnamed nodes and comments. It includes the
#' pairs, brackets, braces, commas, colons, double quotes and string escape
#' sequences as separate nodes.
#'
#' See [ts_tree_dom()] for a tree that shows the semantic structure of the
#' parsed document.
#'
#' @section Example output:
#'
#' ```{r}
#' tree <- ts_tree_read_jsonc(text = '{"foo": 42, "bar": [1, 2, 3]}')
#' ts_tree_ast(tree)
#' ```
#'
#' ```{r}
#' ts_tree_dom(tree)
#' ```
#'
#' @param tree A tsjsonc object as returned by [ts_tree_read_jsonc()].
#' @inherit ts::ts_tree_ast return
#' @seealso [ts_tree_dom()] to show the document object model (DOM) of a
#'   ts_tree object.
#' @family tsjsonc functions
#' @examples
#' # see the output above
#' tree <- ts_tree_read_jsonc(text = '{"foo": 42, "bar": [1, 2, 3]}')
#' tree
#' ts_tree_ast(tree)
#' ts_tree_dom(tree)
#' @name ts_tree_ast
NULL

#' Print the document object model (DOM) of a JSONC tree-sitter tree
#'
#' `ts_tree_dom()` prints the document object model (DOM) tree of a ts_tree
#' object. This tree only includes semantic elements. It includes objects,
#' arrays and various value types, but not the syntax elements like
#' brackets, commas or colons.
#'
#' @details
#' ## The ts and tsjsonc packages:
#' [ts::ts_tree_dom()] is defined in the [ts package][ts::ts] and it is
#' re-exported from tsjsonc.
#'
#' ## The syntax tree and the DOM tree
#'
#' See [ts_tree_ast()] for the complete tree-sitter syntax tree that
#' includes all nodes, including syntax elements like brackets and commas.
#'
#' @section Examples:
#'
#' ```{r}
#' tree <- ts_tree_read_jsonc(text = '{"foo": 42, "bar": [1, 2, 3]}')
#' ts_tree_ast(tree)
#' ```
#'
#' ```{r}
#' ts_tree_dom(tree)
#' ```
#'
#' @param tree A `ts_tree` object.
#' @inherit ts::ts_tree_dom return
#' @seealso [ts_tree_ast()] to show the annotated synctax tree of a
#'   tsjsonc object.
#' @family ts_tree functions
#' @examples
#' # see the output above
#' tree <- ts_tree_read_jsonc(text = '{"foo": 42, "bar": [1, 2, 3]}')
#' tree
#' ts_tree_ast(tree)
#' ts_tree_dom(tree)
#' @name ts_tree_dom
NULL
