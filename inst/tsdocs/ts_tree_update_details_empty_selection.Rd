#| title: 
# ---
\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{tree <- ts_parse_jsonc("\{ \\"a\\": true, \\"b\\": [1, 2, 3] \}")
tree |> ts_tree_select("new") |> ts_tree_update(as.list(4:6))
}\if{html}{\out{</div>}}\if{html}{\out{
<div class="asciicast" style="color: #B9C0CB;font-family: 'Fira Code',Monaco,Consolas,Menlo,'Bitstream Vera Sans Mono','Powerline Symbols',monospace;line-height: 1.300000"><pre>
#> <span style="color: #6F7783;"># jsonc (13 lines)</span>                                                              
#> <span style="color: #6F7783;"> 1 | </span>\{                                                                          
#> <span style="color: #6F7783;"> 2 | </span>    "a": true,                                                             
#> <span style="color: #6F7783;"> 3 | </span>    "b": &#91;                                                                 
#> <span style="color: #6F7783;"> 4 | </span>        1,                                                                 
#> <span style="color: #6F7783;"> 5 | </span>        2,                                                                 
#> <span style="color: #6F7783;"> 6 | </span>        3                                                                  
#> <span style="color: #6F7783;"> 7 | </span>    &#93;,                                                                     
#> <span style="color: #6F7783;"> 8 | </span>    "new": &#91;                                                               
#> <span style="color: #6F7783;"> 9 | </span>        4,                                                                 
#> <span style="color: #6F7783;">10 | </span>        5,                                                                 
#> <span style="color: #6F7783;">ℹ 3 more lines</span>                                                                  
#> <span style="color: #6F7783;">ℹ Use `print(n = ...)` to see more lines</span>                                        
</pre></div>
}}
