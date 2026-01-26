#| title: 
# ---
\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{tree <- tsjsonc::ts_parse_jsonc("\{ \\"a\\": true, \\"b\\": [1, 2, 3] \}")
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{ts_tree_unserialize(tree)
}\if{html}{\out{</div>}}\if{html}{\out{
<div class="asciicast" style="color: #B9C0CB;font-family: 'Fira Code',Monaco,Consolas,Menlo,'Bitstream Vera Sans Mono','Powerline Symbols',monospace;line-height: 1.300000"><pre>
#> &#91;&#91;1&#93;&#93;                                                                           
#> &#91;&#91;1&#93;&#93;$a                                                                         
#> &#91;1&#93; TRUE                                                                        
#>                                                                                 
#> &#91;&#91;1&#93;&#93;$b                                                                         
#> &#91;&#91;1&#93;&#93;$b&#91;&#91;1&#93;&#93;                                                                    
#> &#91;1&#93; 1                                                                           
#>                                                                                 
#> &#91;&#91;1&#93;&#93;$b&#91;&#91;2&#93;&#93;                                                                    
#> &#91;1&#93; 2                                                                           
#>                                                                                 
#> &#91;&#91;1&#93;&#93;$b&#91;&#91;3&#93;&#93;                                                                    
#> &#91;1&#93; 3                                                                           
#>                                                                                 
#>                                                                                 
#>                                                                                 
</pre></div>
}}
