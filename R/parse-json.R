#' Parse a JSON file or string into a tsjson object
#'
#' Parse a JSON file or string and create a tsjson object that represents
#' its document. This object can then be queried and manipulated.
#'
#' tsjson objects have [`format()`][format.tsjson()] and
#' [`print()`][print.tsjson()] methods to pretty-print them to the screen.
#'
#' They can be converted to a data frame using the
#' [single bracket][tsjson-brackets] operator.
#'
#' @inheritParams token_table
#' @return A tsjson object.
#'
#' @seealso [select()] to select part(s) of a tsjson object,
#'   [unserialize_selected()] to extract the selected part(s),
#'   [format_selected()] to format the selected part(s),
#'   [delete_selected()], [insert_into_selected()] and
#'   [update_selected()] to manipulate it. [save_json()] to save
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
#' parse_json(text = text)
#'
#' # Try to parse the JSON, but comments aren't allowed!
#' try(parse_json(text = text, options = list(allow_comments = FALSE)))
#'
#' # Extract parts of the JSON
#' parse_json(text = text) |> select("b") |> unserialize_selected()
#' parse_json(text = text) |> select("[r]") |> unserialize_selected()
#' parse_json(text = text) |> select("[r]", "that") |> unserialize_selected()
#'
#' # Use a `list()` combining strings and positional indices when
#' # arrays are involved
#' parse_json(text = text) |> select("b", 2) |> unserialize_selected()

parse_json <- function(
  file = NULL,
  text = NULL,
  ranges = NULL,
  options = NULL
) {
  if (!missing(options)) {
    check_named_arg(options)
  }
  options <- as_tsjson_options(options)

  tokens <- ts::ts_parse(ts_language_json(), file, text, ranges = ranges)

  # TODO make this a proper error, mark the position of the comment(s)
  if (!options[["allow_comments"]]) {
    comments <- which(tokens$type == "comment")
    if (length(comments) > 0) {
      stop(cnd(
        "The JSON document contains comments, and this is not allowed. \\
         To allow comments, set the `allow_comments` option to `TRUE`."
      ))
    }
  }

  top <- tokens$children[[1]]
  top <- top[tokens$type[top] != "comment"]
  if (!options[["allow_empty_content"]] && length(top) == 0) {
    stop(cnd(
      "The JSON document is empty, and this is not allowed. \\
       To allow this, set the `allow_empty_content` option to `TRUE`."
    ))
  }

  # TODO make this a proper error, mark the position of the trailing comma(s)
  if (!options[["allow_trailing_comma"]]) {
    commas <- which(tokens$type == ",")
    trailing <- map_lgl(commas, function(c) {
      siblings <- tokens$children[[tokens$parent[c]]]
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

  tokens
}
