#| title: 
# ---
\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{tree <- ts_parse_jsonc("\{ \\"a\\": true, \\"b\\": [1, 2, 3] \}")
tree |> ts_tree_update(as.list(4:6))
}\if{html}{\out{</div>}}\if{html}{\out{
<div class="asciicast" style="color: #B9C0CB;font-family: 'Fira Code',Monaco,Consolas,Menlo,'Bitstream Vera Sans Mono','Powerline Symbols',monospace;line-height: 1.300000"><pre>
#> <span style="color: #6F7783;"># jsonc (5 lines)</span>                                                               
#> <span style="color: #6F7783;">1 | </span>&#91;                                                                           
#> <span style="color: #6F7783;">2 | </span>  4,                                                                        
#> <span style="color: #6F7783;">3 | </span>  5,                                                                        
#> <span style="color: #6F7783;">4 | </span>  6                                                                         
#> <span style="color: #6F7783;">5 | </span>&#93;                                                                           
</pre></div>
}}
