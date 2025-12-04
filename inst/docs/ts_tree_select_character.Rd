\subsection{JSONC example}{\if{html}{\out{
<p/>
}}


\if{html}{\out{<div class="sourceCode r">}}\preformatted{json <- tsjsonc::ts_parse_jsonc(
  '\{ "a": 1, "b": [10, 20, 30], "c": \{ "c1": true, "c2": null \} \}'
)
json |> ts_tree_select(c("a", "c"), c("c1"))
}\if{html}{\out{</div>}}\if{html}{\out{
<div class="asciicast" style="color: #B9C0CB;font-family: 'Fira Code',Monaco,Consolas,Menlo,'Bitstream Vera Sans Mono','Powerline Symbols',monospace;line-height: 1.300000"><pre>
#> <span style="color: #6F7783;"># jsonc (1 line, 1 selected element)</span>                                            
#> <span style="background-color: #66C2CD;">&gt;</span> <span style="color: #6F7783;">1 | </span>\{ "a": 1, "b": &#91;10, 20, 30&#93;, "c": \{ "c1": <span style="color: #66C2CD;">true</span>, "c2": null \} \}            
</pre></div>
}}

}
