#| title: JSONC example
# ---
\if{html}{\out{<div class="sourceCode r">}}\preformatted{json <- tsjsonc::ts_parse_jsonc(
 '\{ "apple": 1, "almond": 2, "banana": 3, "cherry": 4 \}'
)
json |> ts_tree_select(regex = "^a")
}\if{html}{\out{</div>}}\if{html}{\out{
<div class="asciicast" style="color: #B9C0CB;font-family: 'Fira Code',Monaco,Consolas,Menlo,'Bitstream Vera Sans Mono','Powerline Symbols',monospace;line-height: 1.300000"><pre>
#> <span style="color: #6F7783;"># jsonc (1 line, 2 selected elements)</span>                                           
#> <span style="background-color: #66C2CD;">&gt;</span> <span style="color: #6F7783;">1 | </span>\{ "apple": <span style="color: #66C2CD;">1</span>, "almond": <span style="color: #66C2CD;">2</span>, "banana": 3, "cherry": 4 \}                     
</pre></div>
}}
