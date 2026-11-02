module lang::cobol85::\syntax::Layout 



layout LAYOUTLIST  =
  LAYOUT* !>> [\t-\n \  ,;] 
  ;

// the preprocessor puts 6 spaces before the indicator column
lexical LAYOUT

  = @category="comment" ^ "      *" ![\n]* !>> ![\n] $ 
  | @category="comment" ^ "      /" ![\n]* !>> ![\n] $
  | ^ "      -" // a line continuation
  | [\t-\n \ ;,]
  ;
