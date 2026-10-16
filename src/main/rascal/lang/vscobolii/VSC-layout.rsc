module lang::vscobolii::\VSC-layout 



layout LAYOUTLIST  =
  LAYOUT* !>> [\t-\n \  * ,;] 
  ;

lexical LAYOUT
  // "%" ![\n]* [\n] 
  = @category="Comment" "*"@6 ![\n]* $
  | @category="Comment" "/"@6 ![\n]* $
  | ^ Spaces "-"@6 // a line continuation
  | [\t-\n \ ;, ] 
  // | ", " 
  // | ",\n" 
  ;

lexical Spaces
  = [\ ]*;
