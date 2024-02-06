module lang::vscobolii::\VSC-layout 



layout LAYOUTLIST  =
  LAYOUT* !>> [\t-\n \  * ,;] 
  ;

lexical LAYOUT
  // "%" ![\n]* [\n] 
  = @category="Comment" "*"@7 ![\n]* $
  | @category="Comment" "/"@7 ![\n]* $
  | "-"@7 // a line continuation
  | [\t-\n \ ;, ] 
  // | ", " 
  // | ",\n" 
  ;
