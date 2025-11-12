# Select elements in a tsjson object

This function is the heart of tsjson. To delete or manipulate parts of a
JSON document, you need to `select()` those parts first. To insert new
elements into a JSON document, you need to select the arrays or objects
the elements will be inserted into.

## Usage

``` r
select(json, ...)

# S3 method for class 'tsjson'
x[[i, ...]]

select_refine(json, ...)
```

## Arguments

- x, json:

  tsjson object.

- i, ...:

  Selectors, see below.

## Value

A tsjson object, potentially with some elements selected.

## Details

### Selectors

You can use a list of selectors to iteratively refine the selection of
JSON elements, starting from the document element (the default
selection).

For `select()` the list of selectors may be specified in a single list
argument, or as multiple arguments.

Available selectors:

- `TRUE` selects all child elements of the current selections.

- A character vector selects the named child elements from selected
  objects. Selects nothing from arrays.

- A numeric vector selectes the listed child elements from selected
  arrays or objects. Positive (1-based) indices are counted from the
  beginning, negative indices are counted from the end of the array or
  object. E.g. -1 is the last element (if any).

- A character scalar named `"regex"`, with a regular expression. It
  selects the child elements whose keys match the regular expression.
  Selects nothing from arrays.

### Refining selections

`select_refine()` is similar to `select()`, but it starts from the
already selected elements (all of them simultanously), instead of
starting from the document element.

### The `[[` and `[[<-` operators

The `[[` operator works similarly to `select_refine()` on tsjson
objects, but it might be more readable.

The `[[<-` operator works similarly to
[`select<-()`](https://gaborcsardi.github.io/tsjson/reference/select-set.md),
but it might be more readable.

## Examples

``` r
json <- load_json(text = serialize_json(list(
  a = list(a1 = list(1,2,3), a2 = "string"),
  b = list(4, 5, 6),
  c = list(c1 = list("a", "b"))
)))

json
#> # json (21 lines)
#>  1 | {
#>  2 |   "a": {
#>  3 |     "a1": [
#>  4 |       1,
#>  5 |       2,
#>  6 |       3
#>  7 |     ],
#>  8 |     "a2": "string"
#>  9 |   },
#> 10 |   "b": [
#> ℹ 11 more lines
#> ℹ Use `print(n = ...)` to see more lines

# Select object by key
json |> select("a")
#> # json (21 lines, 1 selected element)
#>    1  | {
#> >  2  |   "a": {
#> >  3  |     "a1": [
#> >  4  |       1,
#> >  5  |       2,
#> >  6  |       3
#> >  7  |     ],
#> >  8  |     "a2": "string"
#> >  9  |   },
#>   10  |   "b": [
#>   11  |     4,
#>   12  |     5,
#>   ...   

# Select within select, these are the same
json |> select("a", "a1")
#> # json (21 lines, 1 selected element)
#>    1  | {
#>    2  |   "a": {
#> >  3  |     "a1": [
#> >  4  |       1,
#> >  5  |       2,
#> >  6  |       3
#> >  7  |     ],
#>    8  |     "a2": "string"
#>    9  |   },
#>   10  |   "b": [
#>   ...   
json |> select(list("a", "a1"))
#> # json (21 lines, 1 selected element)
#>    1  | {
#>    2  |   "a": {
#> >  3  |     "a1": [
#> >  4  |       1,
#> >  5  |       2,
#> >  6  |       3
#> >  7  |     ],
#>    8  |     "a2": "string"
#>    9  |   },
#>   10  |   "b": [
#>   ...   

# Select elements of an array
json |> select("b", TRUE)           # all elements
#> # json (21 lines, 3 selected elements)
#>   ...   
#>    8  |     "a2": "string"
#>    9  |   },
#>   10  |   "b": [
#> > 11  |     4,
#> > 12  |     5,
#> > 13  |     6
#>   14  |   ],
#>   15  |   "c": {
#>   16  |     "c1": [
#>   ...   
json |> select("b", 1:2)            # first two elements
#> # json (21 lines, 2 selected elements)
#>   ...   
#>    8  |     "a2": "string"
#>    9  |   },
#>   10  |   "b": [
#> > 11  |     4,
#> > 12  |     5,
#>   13  |     6
#>   14  |   ],
#>   15  |   "c": {
#>   ...   
json |> select("b", c(1, -1))       # first and last elements
#> # json (21 lines, 2 selected elements)
#>   ...   
#>    8  |     "a2": "string"
#>    9  |   },
#>   10  |   "b": [
#> > 11  |     4,
#>   12  |     5,
#> > 13  |     6
#>   14  |   ],
#>   15  |   "c": {
#>   16  |     "c1": [
#>   ...   

# Regular expressions
json |> select(c("a", "c"), c(regex = "1$"))
#> # json (21 lines, 2 selected elements)
#>    1  | {
#>    2  |   "a": {
#> >  3  |     "a1": [
#> >  4  |       1,
#> >  5  |       2,
#> >  6  |       3
#> >  7  |     ],
#>    8  |     "a2": "string"
#>    9  |   },
#>   10  |   "b": [
#>   ...   
#>   13  |     6
#>   14  |   ],
#>   15  |   "c": {
#> > 16  |     "c1": [
#> > 17  |       "a",
#> > 18  |       "b"
#> > 19  |     ]
#>   20  |   }
#>   21  | }
```
