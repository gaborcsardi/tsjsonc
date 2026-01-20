#| title: 
# ---
Format a JSONC file:

\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{tree <- tsjsonc::ts_read_jsonc("config.json")
tree |> ts_tree_format() |> ts_tree_write()
}\if{html}{\out{</div>}}
