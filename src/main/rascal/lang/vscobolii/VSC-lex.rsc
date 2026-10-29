module lang::vscobolii::\VSC-lex

extend lang::vscobolii::KEYWORDS;
extend lang::vscobolii::\VSC-layout;

// todo check precede restriction
// todo: check keywords not allowed in pic strings.
lexical Picture_string = [\t-\n\ ,.;] << Picture_contents \ CobwordKeywords !>> ![\t-\n\ ,.;];

lexical Picture_contents = Picture_char+;

lexical Picture_char
  = [,.;] ![\t-\n\ ]
  | ![\t-\n\ ,.;]
  ;

lexical Quoted_pseudo_text = "==" (![=] | ("=" ![=]))* "==";

syntax Replace_pseudo_text_pair = \replace-pseudo-text-pair: Quoted_pseudo_text 'BY' Quoted_pseudo_text;
syntax Replace_directive
  = \replace-directive-off: 'REPLACE' 'OFF' "."
  | \replace-directive: 'REPLACE' Replace_pseudo_text_pair+ "."
  ;

lexical Id = ([\-0-9A-Za-z] !<< [\-0-9]* [A-Za-z] [\-_0-9A-Za-z]* !>> [\-_0-9A-Za-z]) \ CobwordKeywords
  ;

syntax Nonnumeric
  = NonnumericWhole
  | NonnumericPart+ NonnumericWhole
  ;

lexical NonnumericWhole
  = [\"] DoubleStrChar* [\"]
  | [\'] SingleStrChar* [\']
  ;

lexical NonnumericPart
  = [\"] DoubleStrChar*$
  | [\'] SingleStrChar*$
  ;

lexical DoubleStrChar
  = ![\"\n]
  | [\"] [\"]
  ;

lexical SingleStrChar
  = ![\'\n]
  | [\'] [\']
  // assuming same convention as for "
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
  = [0-9\-+] !<< [0-9]* [,.] [0-9]+ !>> [0-9]
  | [0-9A-Za-z.] !<< [+\-] [0-9]* [,.] [0-9]+ !>> [0-9]
  | Int
  ;

lexical Nat = [0-9\-+.A-Za-z] !<< [0-9]+ !>> [0-9];

lexical Int
  = [0-9A-Za-z.] !<< [+\-] [0-9]+ !>> [0-9]
  | Nat
  ;

syntax Cobword = Id;