#| title: 
# ---
\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{json <- tsjsonc::ts_parse_jsonc("\{ \\"a\\": true, \\"b\\": [1, 2, 3] \}")
json |> ts_tree_select("nonexistent") |> ts_tree_insert("foo")
}\if{html}{\out{</div>}}\if{html}{\out{
<div class="asciicast" style="color: #B9C0CB;font-family: 'Fira Code',Monaco,Consolas,Menlo,'Bitstream Vera Sans Mono','Powerline Symbols',monospace;line-height: 1.300000"><pre>
#> <span style="color: #6F7783;"># jsonc (1 line, 0 selected elements)</span>                                           
#> <span style="color: #6F7783;">1 | </span>\{ "a": true, "b": &#91;1, 2, 3&#93; \}                                               
</pre></div>
}}
