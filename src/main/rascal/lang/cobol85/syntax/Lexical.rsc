module lang::cobol85::\syntax::Lexical

extend lang::cobol85::\syntax::Layout;

// the reserved words of this module
keyword CobwordKeywords
    = 'BY'
    | 'OFF'
    | 'REPLACE'
    ;

// todo check precede restriction
// todo: check keywords not allowed in pic strings.
lexical PictureString = [\t-\n\ ,.;] << PictureContents \ CobwordKeywords !>> ![\t-\n\ ,.;] !>> ",." !>> ";.";

// longest match: in 9,9,. the last comma is part of the picture
lexical PictureContents = PictureChar+;

lexical PictureChar
    = [,.;] >> ![\t-\n\ ]
    | ![\t-\n\ ,.;]
    ;

lexical QuotedPseudoText = "==" (![=] | ("=" ![=]))* "==";

syntax ReplacePseudoTextPair = by: QuotedPseudoText 'BY' QuotedPseudoText;
syntax ReplaceDirective
    = replaceOff: 'REPLACE' 'OFF' "."
    | replace: 'REPLACE' ReplacePseudoTextPair+ "."
    ;

lexical Id = ([\-0-9A-Za-z] !<< [\-0-9]* [A-Za-z] [\-_0-9A-Za-z]* !>> [\-_0-9A-Za-z]) \ CobwordKeywords;

syntax Nonnumeric = NonnumericPart* NonnumericWhole;

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

// a sign glued to a number belongs to it: -1 is a literal, A -1 is A minus 1 only with a space after the minus
lexical Num
    = decimal: [0-9\-+] !<< [0-9]* [,.] [0-9]+ !>> [0-9]
    | signedDecimal: [0-9A-Za-z.] !<< [+\-] [0-9]* [,.] [0-9]+ !>> [0-9]
    | signedInteger: [0-9A-Za-z.] !<< [+\-] Digits
    | integer: [0-9\-+.A-Za-z] !<< Digits
    ;

// longest match: 1,5 is a decimal number, not 1 followed by 5
// TODO: write as `!>> ([,][0-9])` once the parser generator supports sequence conditions (0.43.0 silently drops them)
lexical Digits = [0-9]+ !>> [0-9] !>> ",0" !>> ",1" !>> ",2" !>> ",3" !>> ",4" !>> ",5" !>> ",6" !>> ",7" !>> ",8" !>> ",9";
