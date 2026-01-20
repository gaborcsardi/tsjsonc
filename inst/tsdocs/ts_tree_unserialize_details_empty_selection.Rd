#| title: 
# ---
\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{tree <- ts_parse_jsonc("\{ \\"a\\": true, \\"b\\": [1, 2, 3] \}")
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{tree |> ts_tree_select("nope") |> ts_tree_unserialize()
}\if{html}{\out{</div>}}\if{html}{\out{
<div class="asciicast" style="color: #B9C0CB;font-family: 'Fira Code',Monaco,Consolas,Menlo,'Bitstream Vera Sans Mono','Powerline Symbols',monospace;line-height: 1.300000"><pre>
#> list()                                                                          
</pre></div>
}}
