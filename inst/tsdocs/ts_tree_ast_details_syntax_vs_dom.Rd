#| title: 
# ---
\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{tree <- ts_parse_jsonc("\{ \\"a\\": true, \\"b\\": [1, 2, 3] \}")
}\if{html}{\out{</div>}}

\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{ts_tree_ast(tree)
}\if{html}{\out{</div>}}\if{html}{\out{
<div class="asciicast" style="color: #B9C0CB;font-family: 'Fira Code',Monaco,Consolas,Menlo,'Bitstream Vera Sans Mono','Powerline Symbols',monospace;line-height: 1.300000"><pre>
#> document (1)                   1|                                               
#> └─object (2)                    |                                               
#>   ├─\{ (3)                       |\{                                              
#>   ├─pair (4)                    |                                               
#>   │ ├─string (5)                |                                               
#>   │ │ ├─" (6)                   |  "                                            
#>   │ │ ├─string_content (7)      |   a                                           
#>   │ │ └─" (8)                   |    "                                          
#>   │ ├─: (9)                     |     :                                         
#>   │ └─true (10)                 |       true                                    
#>   ├─, (11)                      |           ,                                   
#>   ├─pair (12)                   |                                               
#>   │ ├─string (13)               |                                               
#>   │ │ ├─" (14)                  |             "                                 
#>   │ │ ├─string_content (15)     |              b                                
#>   │ │ └─" (16)                  |               "                               
#>   │ ├─: (17)                    |                :                              
#>   │ └─array (18)                |                                               
#>   │   ├─&#91; (19)                  |                  &#91;                            
#>   │   ├─number (20)             |                   1                           
#>   │   ├─, (21)                  |                    ,                          
#>   │   ├─number (22)             |                      2                        
#>   │   ├─, (23)                  |                       ,                       
#>   │   ├─number (24)             |                         3                     
#>   │   └─&#93; (25)                  |                          &#93;                    
#>   └─\} (26)                      |                            \}                  
</pre></div>
}}


\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{ts_tree_dom(tree)
}\if{html}{\out{</div>}}\if{html}{\out{
<div class="asciicast" style="color: #B9C0CB;font-family: 'Fira Code',Monaco,Consolas,Menlo,'Bitstream Vera Sans Mono','Powerline Symbols',monospace;line-height: 1.300000"><pre>
#> document (1)                                                                    
#> └─object (2)                                                                    
#>   ├─true (10)<span style="color: #6F7783;"> # a</span>                                                               
#>   └─array (18)<span style="color: #6F7783;"> # b</span>                                                              
#>     ├─number (20)                                                               
#>     ├─number (22)                                                               
#>     └─number (24)                                                               
</pre></div>
}}
