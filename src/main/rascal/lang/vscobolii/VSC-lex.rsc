module lang::vscobolii::\VSC-lex 



extend lang::vscobolii::KEYWORDS;
extend lang::vscobolii::\VSC-layout;


// todo check precede restriction
lexical Picture_string =
  [\t-\n\ ] << ((  [, . ;]  ![\t-\n \ ]  ) | ![\t-\n \  , . ;])+ !>> ![\t-\n\ ,.l]
  ;

lexical Quoted_pseudo_text =
  "==" ![=]* "==" 
  ;

lexical Id =
    ([\- 0-9 A-Z a-z] !<< [\- 0-9]* [A-Z a-z] [\- 0-9 A-Z a-z]* !>> [\- 0-9 A-Z a-z]) \ CobwordKeywords
  | [0-9] !<< [0-9]+ (  [\-]  [0-9]+  )+ !>> [0-9]
  ;

lexical Nonnumeric =
  [\"] ![\"]* [\"] 
  | [\'] ![\']* [\'] 
  ;

lexical Num =
  [0-9\-+] !<< [+ \-]? ((  [0-9]*  [, .]  [0-9]+  ) | [0-9]+) !>> [0-9]
  ;

syntax Cobword =
  Id 
  ;

