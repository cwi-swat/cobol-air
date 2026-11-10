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
@synopsis{The PROCEDURE DIVISION: its header, declaratives, sections, paragraphs and sentences.}
@description{
This module defines the structure of the procedure division: the header with its optional USING phrase, the
DECLARATIVES part with its sections and USE statements, and the body as paragraphs that may be grouped into
sections with a header and an optional segment priority number. A paragraph consists of sentences, and a sentence
is a list of statements from the Statement module ending with a period; COPY statements may also stand in place of
a sentence. Paragraphs before the first section header are allowed, as in programs without sections.
}
module lang::cobol85::\syntax::ProcedureDivision

extend lang::cobol85::\syntax::Statement;
extend lang::cobol85::\syntax::Expression;

syntax ProcedureDivision
    = procedureDivision: 'PROCEDURE' 'DIVISION' UsingPhrase Paragraphs SectionWithHeader*
    | procedureDivision: 'PROCEDURE' 'DIVISION' UsingPhrase 'DECLARATIVES' "." DeclarativesContent+ 'END' 'DECLARATIVES' "." Paragraphs SectionWithHeader*
    ;

syntax UsingPhrase
    = copy: CopyStatement
    | copy: 'USING' Id* CopyStatement
    | using: UsingDataNamePluslist? "."
    ;

syntax SectionWithHeader = sectionHeader: SectionHeader "." Paragraphs;

syntax DeclarativesContent = sectionHeader: SectionHeader "." UseStatement "." Paragraphs;

syntax SectionHeader = section: SectionName 'SECTION' PriorityNumber?;

syntax Paragraphs = items: ParagraphItem* Paragraph*;

syntax Paragraph
    = items: ParagraphName "." ParagraphItem*
    | go: ParagraphName "." 'GO' 'TO'? "."
    ;

syntax ParagraphItem
    = sentence: Sentence
    | replaceDirective: ReplaceDirective
    ;

syntax Sentence
    = statementList: StatementList "."+
    | copy: StatementList? CopyStatement
    ;

keyword CobwordKeywords
    = 'DECLARATIVES'
    | 'DIVISION'
    | 'END'
    | 'GO'
    | 'PROCEDURE'
    | 'SECTION'
    | 'TO'
    | 'USING'
    ;
