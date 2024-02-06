module lang::vscobolii::\VSC-lex 



extend lang::vscobolii::KEYWORDS;
extend lang::vscobolii::\VSC-layout;


// todo check precede restriction
// todo: check keywords not allowed in pic strings.
lexical Picture_string =
  [\t-\n\ ] << Picture_contents \ CobwordKeywords !>> ![\t-\n\ ,.l] 
  ;

lexical Picture_contents
  = ((  [, . ;]  ![\t-\n \ ]  ) | ![\t-\n \  , . ;])+ 
  ;

lexical Quoted_pseudo_text =
  "==" ![=]* "==" 
  ;

lexical Id =
    ([\- 0-9 A-Z a-z] !<< [\- 0-9]* [A-Z a-z] [\- _ 0-9 A-Z a-z]* !>> [\- 0-9 A-Z a-z]) \ CobwordKeywords
  | [0-9] !<< [0-9]+ (  [\-]  [0-9]+  )+ !>> [0-9]
  ;


syntax Nonnumeric
  = NonnumericWhole
  | NonnumericPart+ NonnumericWhole
  ;

lexical NonnumericWhole = 
    [\"] DoubleStrChar* [\"] 
  | [\'] SingleStrChar* [\'] ;

lexical NonnumericPart
  = [\"] DoubleStrChar* $
  | [\'] SingleStrChar* $
  ;

lexical DoubleStrChar
  = ![\"\n]
  | [\"][\"]
  ;

lexical SingleStrChar
  = ![\'\n]
  | [\'][\'] // assuming same convention as for "
  ;

// lexical Nonnumeric_ =
//   [\"] ![\"]* [\"] 
//   | [\'] ![\']* [\'] 
//   ;

// lexical Num_ =
//   [0-9\-+] !<< 
//     [+ \-]? (  ( [0-9]*  [, .]  [0-9]+  ) | [0-9]+) !>> [0-9]
//   ;

lexical Num
  = [0-9\-+] !<< [+ \-]?  [0-9]*  [,.]  [0-9]+ !>> [0-9] 
  | [0-9\-+.] !<< [+ \-]?  [0-9]+ !>> [0-9]
  ;

syntax Cobword =
  Id 
  ;

