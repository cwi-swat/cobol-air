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
@synopsis{Cobol84 Report syntax: REPORT clause for FileDescriptionEntry, Report sections with contents}
@description{
The Report Writer: the REPORT clause of FD entries, the REPORT SECTION with RD entries and report group
descriptions, the INITIATE, GENERATE, TERMINATE and SUPPRESS statements, USE BEFORE REPORTING, and the
LINE-COUNTER and PAGE-COUNTER special registers.

This feature is not part of VS COBOL II. It was part of COBOL-68 and COBOL-74 (and IBM's OS/VS COBOL), and
is the optional Report Writer module of COBOL-85 (ANSI X3.23-1985), which this module follows. VS COBOL II
dropped it; IBM offered a separate Report Writer precompiler instead. COBOL 2002 added more clauses
(e.g. OCCURS and PRESENT WHEN in report groups) that are not included here.
}
module lang::cobol85::\syntax::ReportSection

extend lang::cobol85::\syntax::DataDivision;
extend lang::cobol85::\syntax::Statement;

syntax DataSection = report: ReportSection;

syntax ReportSection = reportSection: 'REPORT' 'SECTION' "." ReportDescription*;

syntax ReportDescription = rd: 'RD' Id ReportDescriptionClause* "." ReportGroupDescriptionEntry*;

syntax ReportDescriptionClause
    = globalClause: GlobalClause
    | code: 'CODE' 'IS'? Literal
    | control: 'CONTROL' 'IS'? ControlNames
    | control: 'CONTROLS' 'ARE'? ControlNames
    // PAGE LIMIT IS 60 LINES HEADING 1 FIRST DETAIL 5 LAST DETAIL 55 FOOTING 58
    | page: 'PAGE' PageLimit? Integer AltLineLines? PagePhrase*
    ;

// the control data names, from the most to the least major
syntax ControlNames
    = final: 'FINAL' Id*
    | dataName: Id+
    ;

syntax PageLimit
    = limit: 'LIMIT' 'IS'?
    | limit: 'LIMITS' 'ARE'?
    ;

syntax AltLineLines
    = line: 'LINE'
    | lines: 'LINES'
    ;

// COBOL-85 fixes the order HEADING, FIRST DETAIL, LAST DETAIL, FOOTING; compilers accept any order
syntax PagePhrase
    = heading: 'HEADING' 'IS'? Integer
    | first: 'FIRST' 'DETAIL' 'IS'? Integer
    | last: 'LAST' 'DETAIL' 'IS'? Integer
    | footing: 'FOOTING' 'IS'? Integer
    ;

// The three formats of the standard (a report group with TYPE at level 01, a group, and an elementary item)
// share one list of clauses, in any order.
syntax ReportGroupDescriptionEntry
    = // the follow restriction ensures that digits are eaten up by picture strings (as in Data_description_entry)
     entry: Num ! decimal ! signedDecimal ! signedInteger !>> [.,] AltDataNameFiller? ReportGroupClause* "."
    | copy: CopyStatement
    ;

syntax ReportGroupClause
    = line: 'LINE' 'NUMBER'? 'IS'? LineNumber
    | next: 'NEXT' 'GROUP' 'IS'? NextGroup
    | \type: 'TYPE' 'IS'? ReportGroupType
    | usage: Usage
    | usage: 'USAGE' 'IS'? Usage
    | picture: Picture 'IS'? PictureString
    | sign: 'SIGN' 'IS'? AltLeadingTrailing 'SEPARATE' 'CHARACTER'?
    | sign: AltLeadingTrailing 'SEPARATE' 'CHARACTER'?
    | justified: Justified 'RIGHT'?
    | blank: 'BLANK' 'WHEN'? Zeroes
    | column: 'COLUMN' 'NUMBER'? 'IS'? Integer
    | group: 'GROUP' 'INDICATE'?
    | source: 'SOURCE' 'IS'? Identifier
    | \value: 'VALUE' 'IS'? Literal
    // SUM A B UPON DETAIL-1 RESET ON FINAL; several SUM clauses can follow each other, the RESET phrase ends the last
    | sum: 'SUM' Identifier+ UponPhrase? ResetPhrase?
    ;

syntax LineNumber
    = integer: Integer
    | integerNextPage: Integer 'ON'? 'NEXT' 'PAGE'
    | plus: 'PLUS' Integer
    // COBOL-74
    | nextPage: 'NEXT' 'PAGE'
    ;

syntax NextGroup
    = integer: Integer
    | plus: 'PLUS' Integer
    | nextPage: 'NEXT' 'PAGE'
    ;

syntax ReportGroupType
    = reportHeading: 'REPORT' 'HEADING'
    | reportHeading: 'RH'
    | pageHeading: 'PAGE' 'HEADING'
    | pageHeading: 'PH'
    | controlHeading: 'CONTROL' 'HEADING' ControlName
    | controlHeading: 'CH' ControlName
    | detail: 'DETAIL'
    | detail: 'DE'
    | controlFooting: 'CONTROL' 'FOOTING' ControlName
    | controlFooting: 'CF' ControlName
    | pageFooting: 'PAGE' 'FOOTING'
    | pageFooting: 'PF'
    | reportFooting: 'REPORT' 'FOOTING'
    | reportFooting: 'RF'
    ;

syntax UponPhrase = upon: 'UPON' Id+;

syntax ResetPhrase = reset: 'RESET' 'ON'? ControlName;

syntax ControlName
    = final: 'FINAL'
    | dataName: Id
    ;

// the records of a report file are described by its report groups, so its FD has no record descriptions
syntax FileSectionEntry = reportFd: AltFdSd Id FileAndSortDescriptionEntryClause* ".";

// FD PRINT-FILE REPORT IS SALES-REPORT.
syntax FileAndSortDescriptionEntryClause
    = report: 'REPORT' 'IS'? Id+
    | report: 'REPORTS' 'ARE'? Id+
    ;

syntax UseStatement = useBefore: 'USE' 'GLOBAL'? 'BEFORE' 'REPORTING' Identifier;

syntax Identifier
    = lineCounter: 'LINE-COUNTER'
    | lineCounter: 'LINE-COUNTER' In Id
    | pageCounter: 'PAGE-COUNTER'
    | pageCounter: 'PAGE-COUNTER' In Id
    ;

syntax Statement
    = initiate: 'INITIATE' Id+
    // a report group name (TYPE DETAIL) or a report name (summary reporting)
    | generate: 'GENERATE' QualifiedDataName
    | terminate: 'TERMINATE' Id+
    // only in a USE BEFORE REPORTING procedure
    | suppress: 'SUPPRESS' 'PRINTING'?
    ;

// the reserved words of the Report Writer module
keyword CobwordKeywords
    = 'ARE'
    | 'BEFORE'
    | 'BLANK'
    | 'CF'
    | 'CH'
    | 'CHARACTER'
    | 'CODE'
    | 'COLUMN'
    | 'CONTROL'
    | 'CONTROLS'
    | 'DE'
    | 'DETAIL'
    | 'FINAL'
    | 'FIRST'
    | 'FOOTING'
    | 'GENERATE'
    | 'GLOBAL'
    | 'GROUP'
    | 'HEADING'
    | 'INDICATE'
    | 'INITIATE'
    | 'IS'
    | 'LAST'
    | 'LIMIT'
    | 'LIMITS'
    | 'LINE'
    | 'LINE-COUNTER'
    | 'LINES'
    | 'NEXT'
    | 'NUMBER'
    | 'ON'
    | 'PAGE'
    | 'PAGE-COUNTER'
    | 'PF'
    | 'PH'
    | 'PLUS'
    | 'PRINTING'
    | 'RD'
    | 'REPORT'
    | 'REPORTING'
    | 'REPORTS'
    | 'RESET'
    | 'RF'
    | 'RH'
    | 'RIGHT'
    | 'SECTION'
    | 'SEPARATE'
    | 'SIGN'
    | 'SOURCE'
    | 'SUM'
    | 'SUPPRESS'
    | 'TERMINATE'
    | 'TYPE'
    | 'UPON'
    | 'USAGE'
    | 'USE'
    | 'VALUE'
    | 'WHEN'
    ;
