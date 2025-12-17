docs <- function(page, section) {
  switch(
    section,
    title = "JSONC title",
    description = "JSONC description",
    details = "JSONC details",
    examples = "# JSONC examples",
    "param-tree" = "A tsjsonc object.",
    "param-..." = "Selectors to select parts of the JSONC tree. See Details",
    "param-refine" = "If `TRUE`, refine the current selection instead of
      creating a new one.",
    return = "The updated tsjsonc object"
  )
}
