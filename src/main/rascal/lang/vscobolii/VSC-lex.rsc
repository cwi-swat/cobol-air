module lang::vscobolii::\VSC-lex

extend lang::vscobolii::KEYWORDS;
extend lang::vscobolii::\VSC-layout;

// todo check precede restriction
// todo: check keywords not allowed in pic strings.
lexical Picture_string = [\t-\n\ ,.;] << Picture_contents \ CobwordKeywords !>> ![\t-\n\ ,.;] !>> ",." !>> ";."; // longest match: in 9,9,. the last comma is part of the picture

lexical Picture_contents = Picture_char+;

lexical Picture_char
  = [,.;] >> ![\t-\n\ ]
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
  = [\"] DoubleStrChar* [\"] !>> [\"]
  | [\'] SingleStrChar* [\'] !>> [\']
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

lexical Nat = [0-9\-+.A-Za-z] !<< Digits;

lexical Int
  = [0-9A-Za-z.] !<< [+\-] Digits
  | Nat
  ;

// longest match: 1,5 is a decimal number, not 1 followed by 5
// TODO: write as `!>> ([,][0-9])` once the parser generator supports sequence conditions (0.43.0 silently drops them)
lexical Digits = [0-9]+ !>> [0-9] !>> ",0" !>> ",1" !>> ",2" !>> ",3" !>> ",4" !>> ",5" !>> ",6" !>> ",7" !>> ",8" !>> ",9";

syntax Cobword = Id;