#| title: 
# ---
\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{json <- tsjsonc::ts_parse_jsonc(
  '\{ "a": 1, "b": [10, 20, 30], "c": \{ "c1": true, "c2": 100 \} \}'
)
json |> ts_tree_query("(number) @number")
}\if{html}{\out{</div>}}\if{html}{\out{
<div class="asciicast" style="color: #B9C0CB;font-family: 'Fira Code',Monaco,Consolas,Menlo,'Bitstream Vera Sans Mono','Powerline Symbols',monospace;line-height: 1.300000"><pre>
#> $patterns                                                                       
#> <span style="color: #999999;"># A data frame: 1 × 4</span>                                                           
#>      id name  pattern              match_count                                  
#>   <span style="font-style: italic;color: #999999;">&lt;int&gt;</span> <span style="font-style: italic;color: #999999;">&lt;chr&gt;</span> <span style="font-style: italic;color: #999999;">&lt;chr&gt;</span>                      <span style="font-style: italic;color: #999999;">&lt;int&gt;</span>                                  
#> <span style="color: #c2c2c2;">1</span>     1 <span style="color: #E88388;">NA</span>    <span style="color: #999999;">"</span>(number) @number\\n<span style="color: #999999;">"</span>           5                                  
#>                                                                                 
#> $captures                                                                       
#> <span style="color: #999999;"># A data frame: 1 × 2</span>                                                           
#>      id name                                                                    
#>   <span style="font-style: italic;color: #999999;">&lt;int&gt;</span> <span style="font-style: italic;color: #999999;">&lt;chr&gt;</span>                                                                   
#> <span style="color: #c2c2c2;">1</span>     1 number                                                                  
#>                                                                                 
#> $matched_captures                                                               
#> <span style="color: #999999;"># A data frame: 5 × 12</span>                                                          
#>      id pattern match type  start_byte end_byte start_row start_column          
#>   <span style="font-style: italic;color: #999999;">&lt;int&gt;</span>   <span style="font-style: italic;color: #999999;">&lt;int&gt;</span> <span style="font-style: italic;color: #999999;">&lt;int&gt;</span> <span style="font-style: italic;color: #999999;">&lt;chr&gt;</span>      <span style="font-style: italic;color: #999999;">&lt;int&gt;</span>    <span style="font-style: italic;color: #999999;">&lt;int&gt;</span>     <span style="font-style: italic;color: #999999;">&lt;int&gt;</span>        <span style="font-style: italic;color: #999999;">&lt;int&gt;</span>          
#> <span style="color: #c2c2c2;">1</span>     1       1     1 numb…          7        8         0            7          
#> <span style="color: #c2c2c2;">2</span>     1       1     2 numb…         16       18         0           16          
#> <span style="color: #c2c2c2;">3</span>     1       1     3 numb…         20       22         0           20          
#> <span style="color: #c2c2c2;">4</span>     1       1     4 numb…         24       26         0           24          
#> <span style="color: #c2c2c2;">5</span>     1       1     5 numb…         54       57         0           54          
#> <span style="color: #999999;"># ℹ 4 more variables: end_row &lt;int&gt;, end_column &lt;int&gt;, name &lt;chr&gt;,</span>              
#> <span style="color: #999999;">#   code &lt;chr&gt;</span>                                                                  
#>                                                                                 
</pre></div>
}}
