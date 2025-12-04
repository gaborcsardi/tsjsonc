cat(
  sep = "\n",
  "\\renewcommand{\\eval}{\\Sexpr[stage=render,results=rd,strip.white=false]{#1}}",
  file = "man/macros/eval2.Rd"
)
