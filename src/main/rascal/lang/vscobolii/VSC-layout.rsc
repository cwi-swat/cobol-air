module lang::vscobolii::\VSC-layout 



layout LAYOUTLIST  =
  LAYOUT* !>> [\t-\n \  * ,;] 
  ;

lexical LAYOUT
  = @category="comment" "*"@6 ![\n]* $
  | @category="comment" "/"@6 ![\n]* $
  | ^ Spaces "-"@6 // a line continuation
  | [\t-\n \ ;, ] 
  ;

lexical Spaces
  = [\ ]*;
