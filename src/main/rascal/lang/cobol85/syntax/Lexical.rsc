@license{
Copyright (c) 2026, CWI - Software Analysis and Transformation

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
}
@synopsis{The lexical tokens of COBOL: words, numbers, nonnumeric literals, PICTURE strings and REPLACE directives.}
@description{
This module defines the tokens that the rest of the grammar is built from. `Id` is the single lexical for
user-defined COBOL words, excluding the reserved words that the modules declare in `CobwordKeywords`. `Num` is the
only number lexical; it distinguishes decimals from integers, and a sign glued to its digits makes a signed
literal, so `-1` is a number but `A - 1` is a subtraction. Nonnumeric literals come in double and single quotes,
with doubled quotes inside, and may be continued over several lines up to the margin. `PictureString` reads the
character-string of a PICTURE clause by longest match, so a trailing comma or period ends the clause rather than
the picture. The module also defines pseudo-text (`==...==`) and the REPLACE directive. Follow restrictions,
instead of spacing rules, keep the tokens apart; for example `Digits` may not be followed by a comma and a digit,
so `1,5` is one decimal number.
}
module lang::cobol85::\syntax::Lexical

extend lang::cobol85::\syntax::Layout;

keyword CobwordKeywords
    = 'BY'
    | 'OFF'
    | 'REPLACE'
    ;

// todo check precede restriction
// todo: check keywords not allowed in pic strings.
lexical PictureString = @category="type" [\t-\n\ ,.;\uE000] << PictureContents \ CobwordKeywords !>> ![\t-\n\ ,.;\uE000] !>> ",." !>> ";.";

// longest match: in 9,9,. the last comma is part of the picture
lexical PictureContents = PictureChar+;

lexical PictureChar
    = [,.;] >> ![\t-\n\ \uE000]
    | ![\t-\n\ ,.;\uE000]
    ;

lexical QuotedPseudoText = "==" (![=] | ("=" ![=]))* "==";

syntax ReplacePseudoTextPair = by: QuotedPseudoText 'BY' QuotedPseudoText;

syntax ReplaceDirective
    = replaceOff: 'REPLACE' 'OFF' "."
    | replace: 'REPLACE' ReplacePseudoTextPair+ "."
    ;

lexical Id = @category="struct" ([\-0-9A-Za-z] !<< [\-0-9]* [A-Za-z] [\-_0-9A-Za-z]* !>> [\-_0-9A-Za-z]) \ CobwordKeywords;

syntax Nonnumeric = NonnumericPart* NonnumericWhole;

lexical NonnumericWhole
    = @category="string.quoted.double" [\"] DoubleStrChar* [\"] !>> [\"]
    | @category="string.quoted.single" [\'] SingleStrChar* [\'] !>> [\']
    ;

// a literal that is continued on the next line ends at the margin (column 73) or at the end of a line without one
lexical NonnumericPart
    = @category="string.quoted.double" [\"] DoubleStrChar* !>> ![\n\uE000]
    | @category="string.quoted.single" [\'] SingleStrChar* !>> ![\n\uE000]
    ;

lexical DoubleStrChar
    = ![\"\n\uE000]
    | [\"] [\"]
    ;

lexical SingleStrChar
    = ![\'\n\uE000]
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
