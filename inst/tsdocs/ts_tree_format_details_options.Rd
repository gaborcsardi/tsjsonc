#| title: 
# ---
\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{jsonc <- tsjsonc::ts_parse_jsonc("\{ \\"a\\": [1,2,3] \}") |>
  ts_tree_format()
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{jsonc |> ts_tree_select(TRUE) |>
  ts_tree_format(options = list(format = "oneline"))
}\if{html}{\out{</div>}}\if{html}{\out{
<div class="asciicast" style="color: #B9C0CB;font-family: 'Fira Code',Monaco,Consolas,Menlo,'Bitstream Vera Sans Mono','Powerline Symbols',monospace;line-height: 1.300000"><pre>
#> <span style="color: #6F7783;"># jsonc (3 lines)</span>                                                               
#> <span style="color: #6F7783;">1 | </span>\{                                                                           
#> <span style="color: #6F7783;">2 | </span>    "a": &#91; 1, 2, 3 &#93;                                                        
#> <span style="color: #6F7783;">3 | </span>\}                                                                           
</pre></div>
}}
