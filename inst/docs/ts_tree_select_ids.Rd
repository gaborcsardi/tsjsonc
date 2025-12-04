\emph{JSONC example}\if{html}{\out{
<p/>
}}


\if{html}{\out{<div class="sourceCode r">}}\preformatted{json <- tsjsonc::ts_parse_jsonc(
  '\{ "a": 1, "b": [10, 20, 30], "c": \{ "c1": true, "c2": null \} \}'
)
ts_tree_dom(json)
json |> ts_tree_select(I(18))
}\if{html}{\out{</div>}}\if{html}{\out{
<div class="asciicast" style="color: #B9C0CB;font-family: 'Fira Code',Monaco,Consolas,Menlo,'Bitstream Vera Sans Mono','Powerline Symbols',monospace;line-height: 1.300000"><pre>
#> document (1)                                                                    
#> └─object (2)                                                                    
#>   ├─number (10)<span style="color: #6F7783;"> # a</span>                                                             
#>   ├─array (18)<span style="color: #6F7783;"> # b</span>                                                              
#>   │ ├─number (20)                                                               
#>   │ ├─number (22)                                                               
#>   │ └─number (24)                                                               
#>   └─object (33)<span style="color: #6F7783;"> # c</span>                                                             
#>     ├─true (41)<span style="color: #6F7783;"> # c1</span>                                                            
#>     └─null (49)<span style="color: #6F7783;"> # c2</span>                                                            
#> <span style="color: #6F7783;"># jsonc (1 line, 1 selected element)</span>                                            
#> <span style="background-color: #66C2CD;">&gt;</span> <span style="color: #6F7783;">1 | </span>\{ "a": 1, "b": <span style="color: #66C2CD;">&#91;10, 20, 30&#93;</span>, "c": \{ "c1": true, "c2": null \} \}            
</pre></div>
}}
