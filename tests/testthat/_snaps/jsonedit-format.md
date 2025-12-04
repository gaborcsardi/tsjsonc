# formatting retains comments

    Code
      writeLines(ts_format_jsonc(text = text))
    Output
      
        {
          // a comment
          "a": 1, // another one
          "b": {
              "c": 2
          }
      } // trailing
        

