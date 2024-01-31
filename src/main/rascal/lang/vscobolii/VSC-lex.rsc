module lang::vscobolii::\VSC-lex 



extend lang::vscobolii::KEYWORDS;
extend lang::vscobolii::\VSC-layout;


lexical Picture_string =
  ((  [, . ;]  ![\t-\n \ ]  ) | ![\t-\n \  , . ;])+ 
  ;

lexical Quoted_pseudo_text =
  "==" ![=]* "==" 
  ;

lexical Id =
  [\- 0-9]* [A-Z a-z] [\- 0-9 A-Z a-z]* 
  | [0-9]+ (  [\-]  [0-9]+  )+ 
  ;

lexical Nonnumeric =
  [\"] ![\"]* [\"] 
  | [\'] ![\']* [\'] 
  ;

lexical Num =
  [+ \-]? ((  [0-9]*  [, .]  [0-9]+  ) | [0-9]+) 
  ;

syntax Cobword =
  Id 
  ;
