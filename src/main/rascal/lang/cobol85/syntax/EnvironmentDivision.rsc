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
module lang::cobol85::\syntax::EnvironmentDivision

extend lang::cobol85::\syntax::ConfigurationSection;
extend lang::cobol85::\syntax::InputOutputSection;

keyword CobwordKeywords
    = 'ASSIGN'
    | 'CONFIGURATION'
    | 'DIVISION'
    | 'ENVIRONMENT'
    | 'FILE-CONTROL'
    | 'I-O-CONTROL'
    | 'INPUT-OUTPUT'
    | 'OBJECT-COMPUTER'
    | 'OPTIONAL'
    | 'SECTION'
    | 'SELECT'
    | 'SOURCE-COMPUTER'
    | 'SPECIAL-NAMES'
    | 'TO'
    ;

// the sections, paragraphs and entries of the environment division, in any order; a checker rejects the orders
// COBOL does not allow. One flat list, so that a COPY statement has only one place to go.
syntax EnvironmentDivision = environmentDivision: 'ENVIRONMENT' 'DIVISION' "." EnvironmentEntry*;

syntax EnvironmentEntry
    = configurationSection: 'CONFIGURATION' 'SECTION' "."
    // not `(Id Computer_clause* ".")?`: rascal 0.43.1-RC1 fails on that group when the list in it is empty
    | sourceComputer: 'SOURCE-COMPUTER' "." Id? ComputerClause* "."?
    | objectComputer: 'OBJECT-COMPUTER' "." Id? ComputerClause* "."?
    | specialNames: 'SPECIAL-NAMES' "." SpecialNamesParagraphPhrase* SpecialNamesParagraphClause* "."?
    | inputOutputSection: 'INPUT-OUTPUT' 'SECTION' "."
    | fileControl: 'FILE-CONTROL' "."
    // the clauses may come in any order, also before ASSIGN (as in `SELECT SQ-FS4 RESERVE 1 ASSIGN "SEQ1.DAT"`)
    | select: 'SELECT' 'OPTIONAL'? Id FileControlClause* 'ASSIGN' 'TO'? AltAssignmentNameLiteral+ FileControlClause* "."
    | ioControl: 'I-O-CONTROL' "."
    | ioControlEntries: IoControlEntry+ "."
    // the rest of a paragraph, of the division, or even of the program can come from a copybook
    | copy: CopyStatement
    ;
