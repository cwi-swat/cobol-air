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
module lang::cobol85::\syntax::IdentificationDivision

extend lang::cobol85::\syntax::Expression;

keyword CobwordKeywords
    = 'AUTHOR'
    | 'DATA'
    | 'DATE-COMPILED'
    | 'DATE-WRITTEN'
    | 'ENVIRONMENT'
    | 'ID'
    | 'IDENTIFICATION'
    | 'INSTALLATION'
    | 'PROCEDURE'
    | 'REMARKS'
    | 'SECURITY'
    ;

syntax IdentificationDivisionContent = identificationDivisionPhrase: IdentificationDivisionPhrase*;

syntax Identification
    = id: 'ID'
    | identification: 'IDENTIFICATION'
    ;

// a comment-entry line, up to the margin (or the end of a line without one), so the margin stays layout
lexical MetaDataContentLine
    = Word \ NoIDKeyword ![\n\uE000]* !>> ![\n\uE000]
    // headers start in Area A (columns 8-11), so a comment-entry line in Area B (at least 5 spaces before it, after
    // the margin and the indicator column) can start with a header word, as in `PROCEDURE BUILDS THE EIGHT-RECORD FILE`
    | "     " << NoIDKeyword !>> [a-zA-Z0-9\"()\-] ![\n\uE000]* !>> ![\n\uE000]
    ;

// the first word of a comment-entry line; it stops at a `.`, so `AUTHOR.` is recognized as a paragraph header.
// It does not start with `*` or `/`, because then the line is a comment line (layout).
lexical Word = ![\ \t\n.*/\uE000] ![\ \t\n.\uE000]* !>> ![\ \t\n.\uE000];

keyword NoIDKeyword
    = 'DATE-WRITTEN'
    | 'SECURITY'
    | 'DATE-COMPILED'
    | 'REMARKS'
    | 'INSTALLATION'
    | 'AUTHOR'
    | 'ENVIRONMENT'
    | 'DATA'
    | 'PROCEDURE'
    ;

syntax IdentificationDivisionPhrase
    = security: 'SECURITY' "."? MetaDataContentLine*
    | dateCompiled: 'DATE-COMPILED' "."? MetaDataContentLine*
    | author: 'AUTHOR' "."? MetaDataContentLine*
    | dateWritten: 'DATE-WRITTEN' "."? MetaDataContentLine*
    | remarks: 'REMARKS' "."? MetaDataContentLine*
    | installation: 'INSTALLATION' "."? MetaDataContentLine*
    ;
