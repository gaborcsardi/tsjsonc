#' @ts ts_tree_select_true
#'
#' *JSONC example*
#' <p/>
#'
#' ```{asciicast}
#' json <- tsjsonc::ts_parse_jsonc(
#'   '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
#' )
#' json |> ts_tree_select(c("b", "c"), TRUE)
#' ```
#'
#' @ts ts_tree_select_character
#'
#' *JSONC example*
#' <p/>
#'
#' ```{asciicast}
#' json <- tsjsonc::ts_parse_jsonc(
#'   '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
#' )
#' json |> ts_tree_select(c("a", "c"), c("c1"))
#' ```
#'
#' @ts ts_tree_select_integer
#'
#' *JSONC*
#' <p/>
#'
#' For JSONC positional indices can be used both for arrays and objects.
#' For other nodes nothing is selected.
#' <p/>
#'
#' *JSONC example*
#' <p/>
#'
#' ```{asciicast}
#' json <- tsjsonc::ts_parse_jsonc(
#'   '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
#' )
#' json |> ts_tree_select(c("b", "c"), -1)
#' ```
#'
#' @ts ts_tree_select_regex
#'
#' *JSONC example*
#'
#' ```{asciicast}
#' json <- tsjsonc::ts_parse_jsonc(
#'  '{ "apple": 1, "almond": 2, "banana": 3, "cherry": 4 }'
#' )
#' json |> ts_tree_select(regex = "^a")
#' ```
#'
#' @ts ts_tree_select_tsquery
#'
#' *JSONC*
#' <p/>
#'
#' TODO: details of the JSONC grammar.
#' <p/>
#'
#' *JSONC example*
#' <p/>
#'
#' This example selects all numbers in the JSON document.
#' <p/>
#'
#' ```{asciicast}
#' json <- tsjsonc::ts_parse_jsonc(
#'   '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": 100 } }'
#' )
#' json |> ts_tree_select_query("(number) @number")
#' ```
#'
#' @ts ts_tree_select_ids
#'
#' *JSONC example*
#' <p/>
#'
#' ```{asciicast}
#' json <- tsjsonc::ts_parse_jsonc(
#'   '{ "a": 1, "b": [10, 20, 30], "c": { "c1": true, "c2": null } }'
#' )
#' ts_tree_dom(json)
#' json |> ts_tree_select(I(18))
#' ```
#'
NULL

#' Select elements in a tsjsonc object
#'
#' @details
#' This function is the heart of tsjsonc. To delete or manipulate parts of
#' a JSON document, you need to [ts_tree_select()] those parts first. To
#' insert new elements into a JSON document, you need to select the arrays
#' or objects the elements will be inserted into.
#'
#' ## Selectors
#'
#' You can use a list of selectors to iteratively refine the selection
#' of JSON elements, starting from the document element (the default
#' selection).
#'
#' For [ts_tree_select()] the list of selectors may be specified in a
#' single list argument, or as multiple arguments.
#'
#' Available selectors:
#' - `TRUE` selects all child elements of the current selections.
#' - A character vector selects the named child elements from selected
#'   objects. Selects nothing from arrays.
#' - A numeric vector selectes the listed child elements from selected
#'   arrays or objects. Positive (1-based) indices are counted from the
#'   beginning, negative indices are counted from the end of the array or
#'   object. E.g. -1 is the last element (if any).
#' - A character scalar named `"regex"`, with a regular expression.
#'   It selects the child elements whose keys match the regular expression.
#'   Selects nothing from arrays.
#'
#' ## Refining selections
#'
#' If the `refine` argument of [ts_tree_select()] is `TRUE`, then
#' the selection starts from the already selected elements (all of them
#' simultanously), instead of starting from the document element.
#'
#' ## The `[[` and `[[<-` operators
#'
#' The `[[` operator works similarly to [ts_tree_select())] on tsjsonc
#' objects, but it might be more readable.
#'
#' The `[[<-` operator works similarly to [ts_tree_select<-()], but it
#' might be more readable.
#'
#' @param x,json tsjsonc object.
#' @param i,... Selectors, see below.
#' @return A tsjsonc object, potentially with some elements selected.
#'
#' @examples
#' library(ts)
#' json <- ts_parse_jsonc(ts_serialize_jsonc(list(
#'   a = list(a1 = list(1,2,3), a2 = "string"),
#'   b = list(4, 5, 6),
#'   c = list(c1 = list("a", "b"))
#' )))
#'
#' json
#'
#' # Select object by key
#' json |> ts_tree_select("a")
#'
#' # Select within select, these are the same
#' json |> ts_tree_select("a", "a1")
#' json |> ts_tree_select(list("a", "a1"))
#'
#' # Select elements of an array
#' json |> ts_tree_select("b", TRUE)           # all elements
#' json |> ts_tree_select("b", 1:2)            # first two elements
#' json |> ts_tree_select("b", c(1, -1))       # first and last elements
#'
#' # Regular expressions
#' json |> ts_tree_select(c("a", "c"), c(regex = "1$"))
#' @name ts_tree_select
#' @keywords internal
NULL

#' Select the nodes matching a tree-sitter query in a tsjsonc object
#'
#' See https://tree-sitter.github.io/tree-sitter/ on writing tree-sitter
#' queries. Captured nodes of the TOML document will be selected.
#'
#' @section The JSON grammar:
#'
#' The grammar has the following node types. I included some less important
#' nodes in the subsection of other nodes that they are related to.
#'
#' Comments may appear between any tokens, but they are not part of the
#' grammar.
#'
#' Use the [bracket operator][ts::ts_tree-brackets],
#' [ts::ts_tree_dom()] and [ts::ts_tree_ast()] to explore the parse tree
#' of a JSON document.
#'
#' ## `document`
#'
#' #' A document is a single value.
#'
#' ## Values
#'
#' A value is one of:
#' - `object`,
#' - `array`,
#' - `numebr`,
#' - `string`,
#' - `true`,
#' - `false`,
#' - `null`.
#'
#' ## `object` / `pair`
#'
#' An `object` is a sequence of
#' - `{`,
#' - zero or more `pair` nodes, separated by `,` nodes, trailing commas
#'   are allowed,
#' - `}`.
#'
#' A pair is a series of
#' - a key, a `string` node,
#' - `:`,
#' - a value (see above).
#'
#' ## `array`
#'
#' An `array` is a sequence of
#' - `[`,
#' - zero or more values (see above), separated by `,` nodes, trailing
#'   commas are allowed,
#' - `]`.
#'
#' ## `number`
#'
#' An integer or floating point number. Minus sign is part of the number.
#' Scientific notation is supported.
#'
#' ## `string` / `string_content` / `escape_sequence`
#'
#' A string is a sequence of
#' - a starting double quote (`"`),
#' - zero or more `string_content` or `escape_sequence` nodes,
#' - an ending double quote (`"`).
#'
#' ## `true` / `false` / `null`
#'
#' The literals `true`, `false`, and `null`.
#'
#' @param json tsjsonc object.
#' @param query String, a tree-sitter query.
#'
#' @rdname ts_tree_select
#' @examples
#' # A very simple JSON document
#' library(ts)
#' txt <- "{ \"a\": 1, \"b\": \"foo\", \"c\": 20 }"
#'
#' # Take a look at it
#' ts_parse_jsonc(txt) |> ts_tree_format()
#'
#' # Select all pairs where the value is a number and change them to 100
#' ts_parse_jsonc(txt) |>
#'   ts_tree_select_query("((pair value: (number) @num))") |>
#'   ts_tree_update(100)
# TODO
#' @name select2
#' @keywords internal

NULL

# TODO: keep the parse tree as an external pointer and reuse it.
# TODO: do we need to make sure that there is no recursive selection? Probably.

#' Update selected elements in a tsjsonc object
#'
#' Update the selected elements of a JSON document, using the replacement
#' function syntax.
#'
#' @param x,json tsjsonc object. Create a tsjsonc object with
#'   [ts::ts_tree_new()].
#' @param i,... Selectors, see [ts_tree_select()].
#' @param value New value. Will be serialized to JSON with
#'   [ts_serialize_jsonc()].
#' @return The updated tsjsonc object.
#'
#' @seealso Save the updated tjsonc object to a file with [ts_tree_write()].
#'
#' @rdname select-set
#' @examples
#' library(ts)
#' json <- ts_parse_jsonc("{}")
#'
#' json <- json |>
#'   ts_tree_select("r", "editor.formatOnSave") |>
#'   ts_tree_update(TRUE)
#' json
#'
#' json <- json |>
#'   ts_tree_select("r", "editor.formatOnSave") |>
#'   ts_tree_delete()
#' json
#'
#' # Insert an array
#' json <- json |>
#'   ts_tree_select("foo") |>
#'   ts_tree_update(1:3)
#' json
#'
#' # Update the array at location 2
#' json |> ts_tree_select("foo", 2) |> ts_tree_update(0)
#'
#' # Insert at location 2
#' json |> ts_tree_select("foo") |> ts_tree_insert(0, at = 2)
#'
#' # Insert at the end of the array with `Inf` as `at`
#' json |> ts_tree_select("foo") |> ts_tree_insert(0, at = Inf)
#'
#' # Only the modified elements are reformatted
#' json <- ts_parse_jsonc('{"foo":[1,2],\n"bar":1}')
#' json |> ts_tree_select("foo") |> ts_tree_insert(0, at = Inf)
#'
#' # You can control how those elements are formatted
#' json |> ts_tree_select("foo") |>
#'   ts_tree_insert(0, at = Inf, options = list(indent_width = 2))
#' @name ts_tree_select<-
#' @keywords internal
NULL
