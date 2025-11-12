# tsjson quickstart

tsjson quickstart

## Details

### Create a tsjson object

Create a tsjson object from a string:

    txt <- r"(
    // this is a comment
    {
      "a": {
        "a1": [1, 2, 3],
        // comment
        "a2": "string"
      },
      "b": [
        {
          "b11": true,
          "b12": false
        },
        {
          "b21": false,
          "b22": false
        }
      ]
    }
    )"
    json <- load_json(text = txt)

Pretty print a tsjson object:

    json

    #> # json (19 lines)
    #>  1 | 
    #>  2 | // this is a comment
    #>  3 | {
    #>  4 |   "a": {
    #>  5 |     "a1": [1, 2, 3],
    #>  6 |     // comment
    #>  7 |     "a2": "string"
    #>  8 |   },
    #>  9 |   "b": [
    #> 10 |     {
    #> ℹ 9 more lines
    #> ℹ Use `print(n = ...)` to see more lines

### Select elements in a tsjson object

Select element by objects key:

    select(json, "a")

    #> # json (19 lines, 1 selected element)
    #>    1  | 
    #>    2  | // this is a comment
    #>    3  | {
    #> >  4  |   "a": {
    #> >  5  |     "a1": [1, 2, 3],
    #> >  6  |     // comment
    #> >  7  |     "a2": "string"
    #> >  8  |   },
    #>    9  |   "b": [
    #>   10  |     {
    #>   11  |       "b11": true,
    #>   ...

Select element inside element:

    select(json, "a", "a1")

    #> # json (19 lines, 1 selected element)
    #>   2   | // this is a comment
    #>   3   | {
    #>   4   |   "a": {
    #> > 5   |     "a1": [1, 2, 3],
    #>   6   |     // comment
    #>   7   |     "a2": "string"
    #>   8   |   },
    #>   ...

Select element(s) of an array:

    select(json, "a", "a1", 1:2)

    #> # json (19 lines, 2 selected elements)
    #>   2   | // this is a comment
    #>   3   | {
    #>   4   |   "a": {
    #> > 5   |     "a1": [1, 2, 3],
    #>   6   |     // comment
    #>   7   |     "a2": "string"
    #>   8   |   },
    #>   ...

Select multiple keys from an object:

    select(json, "a", c("a1", "a2"))

    #> # json (19 lines, 2 selected elements)
    #>    2  | // this is a comment
    #>    3  | {
    #>    4  |   "a": {
    #> >  5  |     "a1": [1, 2, 3],
    #>    6  |     // comment
    #> >  7  |     "a2": "string"
    #>    8  |   },
    #>    9  |   "b": [
    #>   10  |     {
    #>   ...

Select nodes that match a tree-sitter query:

    json |> select_query("((pair value: (false) @val))")

    #> Error in select_query(json, "((pair value: (false) @val))") :
    #>   could not find function "select_query"

### Delete elements

Delete selected elements:

    select(json, "a", "a1") |> delete_selected()

    #> # json (18 lines)
    #>  1 | 
    #>  2 | // this is a comment
    #>  3 | {
    #>  4 |   "a": {
    #>  5 |     // comment
    #>  6 |     "a2": "string"
    #>  7 |   },
    #>  8 |   "b": [
    #>  9 |     {
    #> 10 |       "b11": true,
    #> ℹ 8 more lines
    #> ℹ Use `print(n = ...)` to see more lines

### Insert elements

Insert element into an array:

    select(json, "a", "a1") |> insert_into_selected(at = 2, "new")

    #> # json (24 lines)
    #>  1 | 
    #>  2 | // this is a comment
    #>  3 | {
    #>  4 |   "a": {
    #>  5 |     "a1": [
    #>  6 |       1,
    #>  7 |       2,
    #>  8 |       "new",
    #>  9 |       3
    #> 10 |     ],
    #> ℹ 14 more lines
    #> ℹ Use `print(n = ...)` to see more lines

Inserting into an array reformats the array.

Insert element into an object, at the specified key:

    select(json, "a") |>
      insert_into_selected(key = "a0", at = 0, list("new", "element"))

    #> # json (27 lines)
    #>  1 | 
    #>  2 | // this is a comment
    #>  3 | {
    #>  4 |   "a": {
    #>  5 |     "a0": [
    #>  6 |       "new",
    #>  7 |       "element"
    #>  8 |     ],
    #>  9 |     "a1": [
    #> 10 |       1,
    #> ℹ 17 more lines
    #> ℹ Use `print(n = ...)` to see more lines

### Update elements

Update existing element:

    select(json, "a", c("a1", "a2")) |> update_selected("new value")

    #> # json (19 lines)
    #>  1 | 
    #>  2 | // this is a comment
    #>  3 | {
    #>  4 |   "a": {
    #>  5 |     "a1": "new value",
    #>  6 |     // comment
    #>  7 |     "a2": "new value"
    #>  8 |   },
    #>  9 |   "b": [
    #> 10 |     {
    #> ℹ 9 more lines
    #> ℹ Use `print(n = ...)` to see more lines

Inserts the element if some parents are missing:

    json <- load_json(text = "{ \"a\": { \"b\": true } }")
    json

    #> # json (1 line)
    #> 1 | { "a": { "b": true } }

    select(json, "a", "x", "y") |> update_selected(list(1,2,3))

    #> # json (10 lines)
    #>  1 | { "a": {
    #>  2 |   "b": true,
    #>  3 |   "x": {
    #>  4 |     "y": [
    #>  5 |       1,
    #>  6 |       2,
    #>  7 |       3
    #>  8 |     ]
    #>  9 |   }
    #> 10 | } }
