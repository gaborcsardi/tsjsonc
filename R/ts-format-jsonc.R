#' Format a JSONC file
#'
#' @param file Path to a JSONC file. Use one of `file` or `text`.
#' @param text JSONC content as a raw vector or a character vector. Use one
#'  of `file` or `text`.
#' @param options Named list of parsing and formatting options, see
#'  [tsjsonc options][tsjsonc_options].
#' @export

ts_format_jsonc <- function(
  file = NULL,
  text = NULL,
  options = NULL
) {
  if (!missing(options)) {
    ts_check_named_arg(options)
  }
  options <- as_tsjsonc_options(options)

  # parse file/text
  tree <- ts_tree_new(
    ts_language_jsonc(),
    file = file,
    text = text,
    options = options
  )
  fmt <- ts_tree_format(tree, options = options)
  if (!is.null(file)) {
    ts_tree_write(fmt)
  } else {
    strsplit(rawToChar(attr(fmt, "text")), "\n")[[1]]
  }
}
