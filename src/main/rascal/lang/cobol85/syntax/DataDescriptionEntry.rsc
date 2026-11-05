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
module lang::cobol85::\syntax::DataDescriptionEntry

extend lang::cobol85::\syntax::ConfigurationSection;
extend lang::cobol85::\syntax::Lexical;
extend lang::cobol85::\syntax::Expression;

keyword CobwordKeywords
    = 'BINARY'
    | 'BLANK'
    | 'BY'
    | 'CHARACTER'
    | 'COMP'
    | 'COMP-1'
    | 'COMP-2'
    | 'COMP-3'
    | 'COMP-4'
    | 'COMPUTATIONAL'
    | 'COMPUTATIONAL-1'
    | 'COMPUTATIONAL-2'
    | 'COMPUTATIONAL-3'
    | 'COMPUTATIONAL-4'
    | 'DEPENDING'
    | 'DISPLAY'
    | 'DISPLAY-1'
    | 'EXTERNAL'
    | 'FILLER'
    | 'GLOBAL'
    | 'INDEX'
    | 'INDEXED'
    | 'IS'
    | 'JUST'
    | 'JUSTIFIED'
    | 'KEY'
    | 'LEADING'
    | 'LEFT'
    | 'OCCURS'
    | 'ON'
    | 'PACKED-DECIMAL'
    | 'PIC'
    | 'PICTURE'
    | 'POINTER'
    | 'REDEFINES'
    | 'RENAMES'
    | 'RIGHT'
    | 'SEPARATE'
    | 'SIGN'
    | 'SYNC'
    | 'SYNCHRONIZED'
    | 'TIMES'
    | 'TO'
    | 'TRAILING'
    | 'USAGE'
    | 'WHEN'
    | 'ZERO'
    | 'ZEROES'
    | 'ZEROS'
    ;

syntax Picture
    = pic: 'PIC'
    | picture: 'PICTURE'
    ;

syntax Zeroes
    = zeros: 'ZEROS'
    | zero: 'ZERO'
    | zeroes: 'ZEROES'
    ;

syntax ExternalClause = external: 'IS'? 'EXTERNAL';

syntax DataDescriptionEntry
    = // the follow restriction ensures that digits are eaten up by picture strings.
     entry: Num ! decimal ! signedDecimal ! signedInteger !>> [.,] AltDataNameFiller? DataDescriptionEntryClause* "."?
    | copy: CopyStatement
    | replaceDirective: ReplaceDirective
    ;

syntax AltLeftRight
    = \left: 'LEFT'
    | \right: 'RIGHT'
    ;

syntax Justified
    = justified: 'JUSTIFIED'
    | just: 'JUST'
    ;

syntax Synchronized
    = synchronized: 'SYNCHRONIZED'
    | sync: 'SYNC'
    ;

syntax DataDescriptionEntryClause
    = externalClause: ExternalClause
    | globalClause: GlobalClause
    | synchronized: Synchronized AltLeftRight?
    | blank: 'BLANK' 'WHEN'? Zeroes
    | sign: AltLeadingTrailing
    | sign: 'SIGN' 'IS'? AltLeadingTrailing
    | sign: AltLeadingTrailing 'SEPARATE' 'CHARACTER'?
    | sign: 'SIGN' 'IS'? AltLeadingTrailing 'SEPARATE' 'CHARACTER'?
    | values: Values Are? LiteralThroughLiteral+
    | picture: Picture 'IS'? PictureString
    | redefines: 'REDEFINES' Id
    | usage: Usage
    | usage: 'USAGE' 'IS'? Usage
    | renames: 'RENAMES' QualifiedDataName
    | renames: 'RENAMES' QualifiedDataName Through QualifiedDataName
    | justified: Justified 'RIGHT'?
    | occursClause: OccursClause
    ;

syntax GlobalClause = global: 'IS'? 'GLOBAL';

syntax AltLeadingTrailing
    = trailing: 'TRAILING'
    | leading: 'LEADING'
    ;

syntax Usage
    = comp1: 'COMP-1'
    | display: 'DISPLAY'
    | index: 'INDEX'
    | comp3: 'COMP-3'
    | comp2: 'COMP-2'
    | pointer: 'POINTER'
    | computational4: 'COMPUTATIONAL-4'
    | computational1: 'COMPUTATIONAL-1'
    | computational2: 'COMPUTATIONAL-2'
    | binary: 'BINARY'
    | packedDecimal: 'PACKED-DECIMAL'
    | comp: 'COMP'
    | computational: 'COMPUTATIONAL'
    | comp4: 'COMP-4'
    | display1: 'DISPLAY-1'
    | computational3: 'COMPUTATIONAL-3'
    ;

syntax IndexedBy = indexed: 'INDEXED' 'BY'? Id+;

syntax AltDataNameFiller
    = filler: 'FILLER'
    | dataName: Id
    ;

syntax OccursClause
    = occursDepending: 'OCCURS' Integer ('TO' Integer)? 'TIMES'? 'DEPENDING' 'ON'? QualifiedDataName OccursClauseKey* IndexedBy?
    | occurs: 'OCCURS' Integer 'TIMES'? OccursClauseKey* IndexedBy?
    ;

syntax OccursClauseKey = ascendingDescending: AltAscendingDescending 'KEY'? 'IS'? QualifiedDataName+;
