module lang::vscobolii::\VSC-layout 



layout LAYOUTLIST  =
  LAYOUT* !>> [\t-\n \  % ,] 
  ;

lexical LAYOUT =
  "%" ![\n]* [\n] 
  | [\t-\n \ ] 
  | ", " 
  | ",\n" 
  ;
