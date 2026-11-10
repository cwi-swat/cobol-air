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
@synopsis{FD and SD entries: the clauses that describe files and sort files in the FILE SECTION.}
@description{
This module defines the clauses of file description (FD) and sort-merge description (SD) entries: BLOCK
CONTAINS, RECORD CONTAINS and RECORD VARYING, LABEL RECORDS, VALUE OF, DATA RECORDS, LINAGE with its FOOTING, TOP and
BOTTOM phrases, CODE-SET, RECORDING MODE, EXTERNAL and GLOBAL. The clauses and the phrases of LINAGE may come in any
order, and a checker rejects the combinations COBOL does not allow, for example clauses that are only valid for an
FD. The REPORT clause of an FD is added by the ReportSection module.
}
module lang::cobol85::\syntax::FileDescriptionEntry

extend lang::cobol85::\syntax::DataDescriptionEntry;
extend lang::cobol85::\syntax::ConfigurationSection;
extend lang::cobol85::\syntax::Lexical;
extend lang::cobol85::\syntax::Expression;

keyword CobwordKeywords
    = 'AT'
    | 'BLOCK'
    | 'BOTTOM'
    | 'CHARACTERS'
    | 'CODE-SET'
    | 'CONTAINS'
    | 'DATA'
    | 'DEPENDING'
    | 'FD'
    | 'FOOTING'
    | 'FROM'
    | 'IN'
    | 'IS'
    | 'LABEL'
    | 'LINAGE'
    | 'LINES'
    | 'MODE'
    | 'OF'
    | 'OMITTED'
    | 'ON'
    | 'RECORD'
    | 'RECORDING'
    | 'RECORDS'
    | 'SD'
    | 'SIZE'
    | 'STANDARD'
    | 'TO'
    | 'TOP'
    | 'VALUE'
    | 'VARYING'
    | 'WITH'
    ;

syntax AltFdSd
    = fd: 'FD'
    | sd: 'SD'
    ;

syntax AltCharactersRecords
    = characters: 'CHARACTERS'
    | records: 'RECORDS'
    | record: 'RECORD'
    ;

syntax FileAndSortDescriptionEntryClause
    = standard: 'LABEL' Records Are? 'STANDARD'
    | omitted: 'LABEL' Records Are? 'OMITTED'
    | label: 'LABEL' Records Are? Id+
    | block: 'BLOCK' 'CONTAINS'? Integer ('TO' Integer)? AltCharactersRecords?
    | linage: 'LINAGE' 'IS'? AltDataNameInteger 'LINES'? LinagePhrase*
    | recording: 'RECORDING' 'MODE'? 'IS'? Id
    | globalClause: GlobalClause
    | record: 'RECORD' 'CONTAINS'? Integer ('TO' Integer)? 'CHARACTERS'?
    // not ('FROM'? Integer)?: rascal 0.43.1-RC1 mishandles some sequence groups, see EnvironmentDivision.rsc
    | varying: 'RECORD' 'IS'? 'VARYING' 'IN'? 'SIZE'? 'FROM'? Integer? ('TO' Integer)? 'CHARACTERS'? ('DEPENDING' 'ON'? Id)?
    | \data: 'DATA' Records Are? Id+
    | \value: 'VALUE' 'OF' ValueOfPhrase+
    | codeSet: 'CODE-SET' 'IS'? Id
    | externalClause: ExternalClause
    ;

// the phrases of LINAGE, in any order; LINES belongs to the number before it
syntax LinagePhrase
    = footing: 'WITH'? 'FOOTING' 'AT'? AltDataNameInteger 'LINES'?
    | top: 'AT'? 'TOP' AltDataNameInteger 'LINES'?
    | bottom: 'AT'? 'BOTTOM' AltDataNameInteger 'LINES'?
    ;

syntax AltQualifiedDataNameLiteral
    = literal: Literal
    | qualifiedDataName: QualifiedDataName
    ;

syntax AltDataNameInteger
    = dataName: Id
    | integer: Integer
    ;

syntax ValueOfPhrase = systemName: Id 'IS'? AltQualifiedDataNameLiteral;
