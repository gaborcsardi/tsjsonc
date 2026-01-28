#| title: JSONC
# ---
See \code{\link[tsjsonc:ts_language_jsonc]{ts_language_jsonc()}} for
details on the JSONC grammar.\if{html}{\out{
<p>
}}


This example selects all numbers in the JSON document.

\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{json <- tsjsonc::ts_parse_jsonc(
  '\{ "a": 1, "b": [10, 20, 30], "c": \{ "c1": true, "c2": 100 \} \}'
)
json |> ts_tree_select(query = "(number) @number")
}\if{html}{\out{</div>}}\if{html}{\out{
<div class="asciicast" style="color: #B9C0CB;font-family: 'Fira Code',Monaco,Consolas,Menlo,'Bitstream Vera Sans Mono','Powerline Symbols',monospace;line-height: 1.300000"><pre>
#> <span style="color: #6F7783;"># jsonc (1 line, 5 selected elements)</span>                                           
#> <span style="background-color: #66C2CD;">&gt;</span> <span style="color: #6F7783;">1 | </span>\{ "a": <span style="color: #66C2CD;">1</span>, "b": &#91;<span style="color: #66C2CD;">10</span>, <span style="color: #66C2CD;">20</span>, <span style="color: #66C2CD;">30</span>&#93;, "c": \{ "c1": true, "c2": <span style="color: #66C2CD;">100</span> \} \}             
</pre></div>
}}
