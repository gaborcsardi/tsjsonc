# ts_tree_unserialize

    Code
      ts_tree_unserialize(json)
    Output
      [[1]]
      [[1]]$a
      [1] 1
      
      [[1]]$b
      [[1]]$b[[1]]
      [1] 1
      
      [[1]]$b[[2]]
      [1] 2
      
      [[1]]$b[[3]]
      [1] 3
      
      
      

---

    Code
      ts_tree_unserialize(ts_tree_select(json, "a"))
    Output
      [[1]]
      [1] FALSE
      

