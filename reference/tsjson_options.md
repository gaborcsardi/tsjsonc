# tsjson options

Options that control the behavior of tsjson functions.

## Details

### Parsing options:

- `allow_empty_content`: logical, whether to allow empty JSON documents.
  Default is TRUE.

- `allow_comments`: logical, whether to allow comments in JSON
  documents. Default is TRUE.

- `allow_trailing_comma`: logical, whether to allow trailing commas in
  JSON documents. Default is TRUE.

### Formatting options:

- `format`: Formatting style, one of:

  - `"pretty"`: arrays and objects are formatted in multiple lines,

  - `"compact"`: format everything without whitespace,

  - `"oneline"`: format everything without newlines, but include
    whitespace after commas, colons, opening brackets and braces, and
    before closing brackets and braces. Default is
    `rpretty* `indent_width`: integer, the number of spaces to use for indentation when `indent_style`is`"space"\`.
    Default is

  1.  

- `indent_style`: string, either `"space"` or `"tab"`, the type of
  indentation to use. Default is space.
