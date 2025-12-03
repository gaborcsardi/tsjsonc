#' Unserialize a JSON file or string into an R object
#'
#' The purpose of this function is to convert a JSON file or string into
#' an R object reliably.
#'
#' See examples below on how the different JSON elements are mapped to
#' R objects.
#'
#' @inheritParams ts::ts_tree_new
#' @param options Named list of parsing options, see
#'   [tsjsonc options][tsjsonc_options].
#' @return R object.
#'
#' @export
#' @seealso [ts_serialize_jsonc()] for the opposite, [ts_tree_select()] and
#' [ts_tree_unserialize()] to unserialize part(s) of a JSON document.
#' [ts::ts_tree_new()] to load a JSON document and then manipulate it.
#' @examples
#' library(ts)
#' # null -> NULL
#' ts_unserialize_jsonc(text = "null")
#'
#' # true, false -> TRUE, FALSE
#' ts_unserialize_jsonc(text = "true")
#' ts_unserialize_jsonc(text = "false")
#'
#' # string -> character scalar
#' ts_unserialize_jsonc(text = "\"string with escapes: \\b \\ud020\"")
#'
#' # number -> double scalar
#' ts_unserialize_jsonc(text = "42.25")
#'
#' # array -> unnamed list
#' ts_unserialize_jsonc(text = "[1, 2, 3]")
#'
#' # object -> named list
#' ts_unserialize_jsonc(text = "{\"a\": 1, \"b\": 2 }")

ts_unserialize_jsonc <- function(
  file = NULL,
  text = NULL,
  ranges = NULL,
  options = NULL
) {
  if (!missing(options)) {
    ts_check_named_arg(options)
  }
  options <- as_tsjsonc_options(options)
  # parse file/text
  # TODO: error on error, get error position
  tree <- ts_tree_new(
    language = ts_language_jsonc(),
    file = file,
    text = text,
    ranges = ranges,
    options = options
  )

  # document is the top element. easier to process without NA parents
  # TODO: do not fail for empty file, but what to return? NULL, maybe?
  tree$parent[1] <- 0L

  # it must have one non-comment element
  # multiple top-level values (e.g. JSONL) are not (yet) allowed
  top <- tree$children[[1]]
  top <- top[tree$type[top] != "comment"]

  if (length(top) == 0) {
    NULL
  } else {
    unserialize_element(tree, top)
  }
}

#' Unserialize selected elements from a tsjsonc object
#'
#' Uses [ts_tree_unserialize()] on the selected elements.
#'
#' If `json` does not have a selection, then all of it is unserialized.
#' If `json` has an empty selection, then an empty list is returned.
#'
#' @param tree tsjsonc object.
#' @return List of R objects, each the unserialization of a selected element
#'   in tsjsonc.
#'
#' @export
#' @seealso [ts_tree_unserialize()] to unserialize a JSON document from a
#'   file or string. [ts_serialize_jsonc()] to create JSON from R objects.
#' @examples
#' library(ts)
#' json <- ts_parse_jsonc(ts_serialize_jsonc(list(
#'   a = list(a1 = list(1,2,3), a2 = "string"),
#'   b = list(4, 5, 6),
#'   c = list(c1 = list("a", "b"))
#' )))
#' json |> ts_tree_select(c("b", "c")) |> ts_tree_unserialize()

ts_tree_unserialize.ts_tree_jsonc <- function(tree) {
  sel <- ts_tree_selected_nodes(tree)
  as.list(lapply(sel, unserialize_element, tree = tree))
}

unserialize_element <- function(tree, id) {
  switch(
    tree$type[id],
    null = {
      unserialize_null(tree, id)
    },
    true = {
      unserialize_true(tree, id)
    },
    false = {
      unserialize_false(tree, id)
    },
    string = {
      unserialize_string(tree, id)
    },
    number = {
      unserialize_number(tree, id)
    },
    array = {
      unserialize_array(tree, id)
    },
    object = {
      unserialize_object(tree, id)
    }
  )
}

unserialize_null <- function(tree, id) {
  stopifnot(tree$type[id] == "null")
  NULL
}

unserialize_true <- function(tree, id) {
  stopifnot(tree$type[id] == "true")
  TRUE
}

unserialize_false <- function(tree, id) {
  stopifnot(tree$type[id] == "false")
  FALSE
}

unserialize_string <- function(tree, id) {
  stopifnot(tree$type[id] == "string")
  # escapes are almost the same as for R, but R does not have \/
  chdn <- tree$children[[id]]
  str <- paste0(tree$code[chdn], collapse = "")
  str <- gsub("\\/", "/", str, fixed = TRUE)
  # TODO: is there anything simpler than eval(parse(.))?
  eval(parse(text = str, keep.source = FALSE))
}

unserialize_number <- function(tree, id) {
  stopifnot(tree$type[id] == "number")
  # single token
  num <- as.numeric(tree$code[id])
  # integer or double
  numi <- suppressWarnings(as.integer(num))
  if (num == numi) {
    numi
  } else {
    num
  }
}

unserialize_array <- function(tree, id) {
  stopifnot(tree$type[id] == "array")
  chdn <- tree$children[[id]]
  # drop [ and , and ], parse the rest
  chdn <- chdn[!tree$type[chdn] %in% c("[", ",", "]", "comment")]
  arr <- vector("list", length(chdn))
  for (idx in seq_along(chdn)) {
    arr[idx] <- list(unserialize_element(tree, chdn[idx]))
  }
  arr
}

unserialize_object <- function(tree, id) {
  stopifnot(tree$type[id] == "object")
  # keep the pairs, parse their names and values
  chdn <- tree$children[[id]]
  chdn <- chdn[tree$type[chdn] == "pair"]
  arr <- vector("list", length(chdn))
  nms <- character(length(chdn))
  for (idx in seq_along(chdn)) {
    gchdn <- tree$children[[chdn[idx]]]
    gchdn <- gchdn[!is.na(tree$field_name[gchdn])]
    key <- gchdn[tree$field_name[gchdn] == "key"]
    nms[idx] <- unserialize_string(tree, key)
    value <- gchdn[tree$field_name[gchdn] == "value"]
    arr[idx] <- list(unserialize_element(tree, value))
  }
  structure(arr, names = nms)
}
