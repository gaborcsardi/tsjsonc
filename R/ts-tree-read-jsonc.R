#' Parse a JSON file or string into a tsjsonc object
#'
#' Parse a JSON file or string and create a tsjsonc object that
#' represents its document. This object can then be queried and
#' manipulated.
#'
# TODO: add manual page and link it here
#' tsjsonc objects have `format()` and `print()` methods to pretty-print
#' them to the screen.
#'
#' They can be converted to a data frame using the
#' [single bracket][ts::ts_tree-brackets] operator.
#'
# TODO: do not inherit from other package
#' @inheritParams ts::ts_tree_read
#' @param options Named list of parsing options, see
#'   [tsjsonc options][tsjsonc_options].
#' @return A tsjsonc object.
#'
#' @seealso [ts_tree_select()] to select part(s) of a tsjsonc
#'   object, [ts_tree_unserialize()] to extract the selected part(s),
#'   [ts_tree_format()] to format the selected part(s),
#'   [ts_tree_delete()], [ts_tree_insert()] and
#'   [ts_tree_update()] to manipulate it. [ts_tree_write()] to save
#'   the JSON document to a file.
#' @export
#' @examples
#' text <- '
#' {
#'   "a": 1,
#'   "b": [2, 3, 4],
#'   "[r]": {
#'     "this": "setting",
#'     // A comment!
#'     "that": true
#'   }
#' }
#' '
#'
#' # Parse the JSON, allowing comments (i.e. JSONC)
#' ts_tree_read_jsonc(text = text)
#'
#' # Try to parse the JSON, but comments aren't allowed!
#' try(ts_tree_read_jsonc(text = text, options = list(allow_comments = FALSE)))
#'
#' # Extract parts of the JSON
#' ts_tree_read_jsonc(text = text) |>
#'   ts_tree_select("b") |>
#'   ts_tree_unserialize()
#' ts_tree_read_jsonc(text = text) |>
#'   ts_tree_select("[r]") |>
#'   ts_tree_unserialize()
#' ts_tree_read_jsonc(text = text) |>
#'   ts_tree_select("[r]", "that") |>
#'   ts_tree_unserialize()
#'
#' # Use a `list()` combining strings and positional indices when
#' # arrays are involved
#' ts_tree_read_jsonc(text = text) |>
#'   ts_tree_select("b", 2) |>
#'    gts_tree_unserialize()
ts_tree_read_jsonc <- function(
  file = NULL,
  text = NULL,
  ranges = NULL,
  options = NULL,
  fail_on_parse_error = TRUE
) {
  if (!missing(options)) {
    check_named_arg(options)
  }
  options <- as_tsjsonc_options(options)

  tree <- ts::ts_tree_read(
    ts_language_json(),
    file,
    text,
    ranges = ranges,
    fail_on_parse_error = fail_on_parse_error
  )
  class(tree) <- c("tsjsonc", class(tree))

  # to work around a TS bug, these are not terminal nodes
  tree$code[tree$type %in% c("object", "array")] <- NA_character_

  # TODO make this a proper error, mark the position of the comment(s)
  if (!options[["allow_comments"]]) {
    comments <- which(tree$type == "comment")
    if (length(comments) > 0) {
      stop(cnd(
        "The JSON document contains comments, and this is not allowed. \\
         To allow comments, set the `allow_comments` option to `TRUE`."
      ))
    }
  }

  top <- tree$children[[1]]
  top <- top[tree$type[top] != "comment"]
  if (!options[["allow_empty_content"]] && length(top) == 0) {
    stop(cnd(
      "The JSON document is empty, and this is not allowed. \\
       To allow this, set the `allow_empty_content` option to `TRUE`."
    ))
  }

  # TODO make this a proper error, mark the position of the trailing comma(s)
  if (!options[["allow_trailing_comma"]]) {
    commas <- which(tree$type == ",")
    trailing <- map_lgl(commas, function(c) {
      siblings <- tree$children[[tree$parent[c]]]
      c == siblings[length(siblings) - 1L]
    })
    if (any(trailing)) {
      stop(cnd(
        "The JSON document contains trailing commas, and this is not allowed. \\
         To allow trailing commas, set the `allow_trailing_comma` option to \\
         `TRUE`."
      ))
    }
  }

  # create the DOM tree
  tree <- add_dom(tree)

  tree
}

dom_types <- c(
  "null",
  "true",
  "false",
  "string",
  "number",
  "array",
  "object",
  "document"
)


add_dom <- function(tree) {
  tree$dom_children <- vector("list", nrow(tree))
  tree$dom_parent <- rep(NA_integer_, nrow(tree))
  tree$dom_name <- rep(NA_character_, nrow(tree))
  tree$dom_type <- ifelse(tree$type %in% dom_types, tree$type, NA_character_)

  for (i in seq_len(nrow(tree))) {
    if (!tree$type[i] %in% c("document", "object", "array")) {
      next
    }

    chdn <- tree$children[[i]]
    chdn <- chdn[!tree$type[chdn] %in% c("comment", "[", "]", "{", "}", ",")]

    if (tree$type[i] == "object") {
      nms <- rep("", length(chdn))
      for (ci in seq_along(chdn)) {
        gchdn <- tree$children[[chdn[ci]]]
        chdn[ci] <- gchdn[3]
        nms[ci] <- unserialize_string(tree, gchdn[1])
      }
      names(chdn) <- tree$dom_name[chdn] <- nms
    }

    tree$dom_children[[i]] <- chdn
    tree$dom_parent[chdn] <- i
  }

  tree
}
