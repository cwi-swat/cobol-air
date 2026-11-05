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
module lang::cobol85::\syntax::Copybook

extend lang::cobol85::\syntax::Main;

// A copybook is a fragment of a program, so its kind depends on where it is copied. This start nonterminal accepts
// the fragments that are complete constructs; a fragment that is only part of an entry or a statement (the end of a
// data description entry, a single operand) does not parse on its own. Copybooks may fit several alternatives.
start syntax Copybook
    = procedure: Paragraphs SectionWithHeader*
    | dataEntries: DataDescriptionEntry+
    | fileClauses: FileAndSortDescriptionEntryClause+ "."
    | environment: EnvironmentEntry+
    // the rest of a program after `ENVIRONMENT DIVISION.`, as in `COPY K6SCA.`
    | divisions: EnvironmentEntry* DataDivision ProcedureDivision?
    | specialNames: SpecialNamesParagraphPhrase+ SpecialNamesParagraphClause* "."?
    | specialNames: SpecialNamesParagraphClause+ "."?
    ;
