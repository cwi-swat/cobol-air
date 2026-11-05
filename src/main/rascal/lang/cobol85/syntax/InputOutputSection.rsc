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
module lang::cobol85::\syntax::InputOutputSection

extend lang::cobol85::\syntax::FileDescriptionEntry;
extend lang::cobol85::\syntax::Expression;

keyword CobwordKeywords
    = 'ACCESS'
    | 'ALTERNATE'
    | 'APPLY'
    | 'AREA'
    | 'AREAS'
    | 'CHARACTER'
    | 'CONTAINS'
    | 'DELIMITER'
    | 'DUPLICATES'
    | 'DYNAMIC'
    | 'END'
    | 'EVERY'
    | 'FILE'
    | 'FOR'
    | 'INDEXED'
    | 'IS'
    | 'KEY'
    | 'MODE'
    | 'MULTIPLE'
    | 'OF'
    | 'ON'
    | 'ORGANIZATION'
    | 'PADDING'
    | 'PASSWORD'
    | 'POSITION'
    | 'RANDOM'
    | 'RECORD'
    | 'RECORDS'
    | 'RELATIVE'
    | 'RERUN'
    | 'RESERVE'
    | 'SAME'
    | 'SEQUENTIAL'
    | 'SORT'
    | 'SORT-MERGE'
    | 'STANDARD-1'
    | 'STATUS'
    | 'TAPE'
    | 'WITH'
    | 'WRITE-ONLY'
    ;

syntax FileNamePosition = fileName: Id ('POSITION' Integer)?;

syntax RecordDelimiterName
    = assignmentName: Id
    | standard1: 'STANDARD-1'
    ;

syntax RecordSort
    = sort: 'SORT'
    | record: 'RECORD'
    | sortMerge: 'SORT-MERGE'
    ;

syntax AltIndexedRelativeSequential
    = relative: 'RELATIVE'
    | indexed: 'INDEXED'
    | sequential: 'SEQUENTIAL'
    ;

// the entries of the I-O-CONTROL paragraph
syntax IoControlEntry
    = rerun: 'RERUN' 'ON' Id ('EVERY'? EveryPhrase 'OF'? Id)?
    // SAME SORT AREA FOR SQ-FS1 ST-FS1,
    | same: 'SAME' RecordSort? 'AREA'? 'FOR'? Id Id+
    | apply: 'APPLY' 'WRITE-ONLY' 'ON'? Id+
    | multiple: 'MULTIPLE' 'FILE' 'TAPE'? 'CONTAINS'? FileNamePosition+
    ;

syntax EveryPhrase
    = end: 'END' 'OF'? AltReelUnit
    | records: Integer 'RECORDS'
    ;

syntax FileControlClause
    = record: 'RECORD' 'KEY'? 'IS'? QualifiedDataName
    | access: 'ACCESS' 'MODE'? 'IS'? AltSequentialRandomDynamic
    | relativeKey: 'RELATIVE' 'KEY'? 'IS'? QualifiedDataName
    | recordDelimiter: 'RECORD' 'DELIMITER' 'IS'? RecordDelimiterName
    | status: 'FILE'? 'STATUS' 'IS'? QualifiedDataName QualifiedDataName?
    | padding: 'PADDING' 'CHARACTER'? 'IS'? AltQualifiedDataNameLiteral
    | organization: 'ORGANIZATION'? 'IS'? AltIndexedRelativeSequential
    | passwordClause: PasswordClause
    | alternate: 'ALTERNATE' 'RECORD'? 'KEY'? 'IS'? QualifiedDataName PasswordClause?
    | duplicates: 'WITH'? 'DUPLICATES'
    | reserve: 'RESERVE' Integer Areas?
    ;

syntax PasswordClause = password: 'PASSWORD' 'IS'? Id;

syntax AltAssignmentNameLiteral
    = literal: Literal
    | assignmentName: Id
    ;

syntax AltSequentialRandomDynamic
    = random: 'RANDOM'
    | \dynamic: 'DYNAMIC'
    | sequential: 'SEQUENTIAL'
    ;

syntax Areas
    = areas: 'AREAS'
    | area: 'AREA'
    ;
