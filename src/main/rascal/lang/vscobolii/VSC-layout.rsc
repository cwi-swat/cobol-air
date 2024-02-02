module lang::vscobolii::\VSC-layout 



layout LAYOUTLIST  =
  LAYOUT* !>> [\t-\n \  % ,] 
  ;

lexical LAYOUT
  // "%" ![\n]* [\n] 
  = @category="Comment" "*"@7 ![\n]* $
  | [\t-\n \ ] 
  | ", " 
  | ",\n" 
  ;
