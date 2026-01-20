#| title: 
# ---
\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{json <- ts_parse_jsonc("\{ \\"a\\": true, \\"b\\": [1, 2, 3] \}")
json |> ts_tree_select("a") |> ts_tree_insert("foo")
}\if{html}{\out{</div>}}\if{html}{\out{
<div class="asciicast" style="color: #B9C0CB;font-family: 'Fira Code',Monaco,Consolas,Menlo,'Bitstream Vera Sans Mono','Powerline Symbols',monospace;line-height: 1.300000"><pre>
#>   Cannot insert into a 'true' JSON element. Can only insert into 'array' and 'ob
#> ject' elements and empty JSON documents.                                        
</pre></div>
}}
