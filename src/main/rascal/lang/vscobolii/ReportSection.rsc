module lang::vscobolii::ReportSection

// The Report Writer: the REPORT clause of FD entries, the REPORT SECTION with RD entries and report group
// descriptions, the INITIATE, GENERATE, TERMINATE and SUPPRESS statements, USE BEFORE REPORTING, and the
// LINE-COUNTER and PAGE-COUNTER special registers.
//
// This feature is not part of VS COBOL II. It was part of COBOL-68 and COBOL-74 (and IBM's OS/VS COBOL), and
// is the optional Report Writer module of COBOL-85 (ANSI X3.23-1985), which this module follows. VS COBOL II
// dropped it; IBM offered a separate Report Writer precompiler instead. COBOL 2002 added more clauses
// (e.g. OCCURS and PRESENT WHEN in report groups) that are not included here.

extend lang::vscobolii::\VSC-data-div;
extend lang::vscobolii::\VSC-stat;

// the reserved words of the Report Writer module that the rest of the grammar does not reserve yet
keyword CobwordKeywords
  = 'CF' | 'CH' | 'CODE' | 'COLUMN' | 'CONTROL' | 'CONTROLS' | 'DE' | 'DETAIL' | 'FINAL' | 'GENERATE' | 'GROUP'
  | 'HEADING' | 'INDICATE' | 'INITIATE' | 'LAST' | 'LIMIT' | 'LIMITS' | 'LINE-COUNTER' | 'NUMBER' | 'PAGE-COUNTER'
  | 'PF' | 'PH' | 'PLUS' | 'PRINTING' | 'RD' | 'REPORT' | 'REPORTING' | 'REPORTS' | 'RESET' | 'RF' | 'RH' | 'SUM'
  | 'TERMINATE' | 'TYPE'
  ;

syntax Report_name = \report-name: Data_name;

// FD PRINT-FILE REPORT IS SALES-REPORT.
syntax File_and_sort_description_entry_clause
  = \file-and-sort-description-entry-clause-report: 'REPORT' 'IS'? Report_name+
  | \file-and-sort-description-entry-clause-report: 'REPORTS' 'ARE'? Report_name+
  ;

// the records of a report file are described by its report groups, so its FD has no record descriptions
syntax File_section_entry
  = \file-section-entry-report: Alt_fd_sd File_name File_and_sort_description_entry_clause* "."
  ;

// the REPORT SECTION is the last section of the data division
syntax Data_division = \data-division-report: Data_division Report_section;

syntax Report_section = \report-section: 'REPORT' 'SECTION' "." Report_description*;

syntax Report_description
  = \report-description: 'RD' Report_name Report_description_clause* "." Report_group_description_entry*
  ;

syntax Report_description_clause
  = \report-description-clause-global: Global_clause
  | \report-description-clause-code: 'CODE' 'IS'? Literal
  | \report-description-clause-control: 'CONTROL' 'IS'? Control_names
  | \report-description-clause-control: 'CONTROLS' 'ARE'? Control_names
  // PAGE LIMIT IS 60 LINES HEADING 1 FIRST DETAIL 5 LAST DETAIL 55 FOOTING 58
  | \report-description-clause-page: 'PAGE' Page_limit? Integer Alt_line_lines? Page_phrase*
  ;

// the control data names, from the most to the least major
syntax Control_names
  = \control-names-final: 'FINAL' Data_name*
  | \control-names: Data_name+
  ;

syntax Page_limit
  = \page-limit: 'LIMIT' 'IS'?
  | \page-limit: 'LIMITS' 'ARE'?
  ;

syntax Alt_line_lines
  = \alt-line-lines-c1: 'LINE'
  | \alt-line-lines-c2: 'LINES'
  ;

// COBOL-85 fixes the order HEADING, FIRST DETAIL, LAST DETAIL, FOOTING; compilers accept any order
syntax Page_phrase
  = \page-phrase-heading: 'HEADING' 'IS'? Integer
  | \page-phrase-first-detail: 'FIRST' 'DETAIL' 'IS'? Integer
  | \page-phrase-last-detail: 'LAST' 'DETAIL' 'IS'? Integer
  | \page-phrase-footing: 'FOOTING' 'IS'? Integer
  ;

// The three formats of the standard (a report group with TYPE at level 01, a group, and an elementary item)
// share one list of clauses, in any order.
syntax Report_group_description_entry
  = // the follow restriction ensures that digits are eaten up by picture strings (as in Data_description_entry)
    \report-group-description-entry: Nat !>> [.,] Alt_data_name_filler? Report_group_clause* "."
  | \report-group-description-entry-copy: Copy_statement
  ;

syntax Report_group_clause
  = \report-group-clause-line: 'LINE' 'NUMBER'? 'IS'? Line_number
  | \report-group-clause-next-group: 'NEXT' 'GROUP' 'IS'? Next_group
  | \report-group-clause-type: 'TYPE' 'IS'? Report_group_type
  | \report-group-clause-usage: Usage
  | \report-group-clause-usage: 'USAGE' 'IS'? Usage
  | \report-group-clause-picture: Picture 'IS'? Picture_string
  | \report-group-clause-sign: 'SIGN' 'IS'? Alt_leading_trailing 'SEPARATE' 'CHARACTER'?
  | \report-group-clause-sign: Alt_leading_trailing 'SEPARATE' 'CHARACTER'?
  | \report-group-clause-justified: Justified 'RIGHT'?
  | \report-group-clause-blank-when-zero: 'BLANK' 'WHEN'? Zeroes
  | \report-group-clause-column: 'COLUMN' 'NUMBER'? 'IS'? Integer
  | \report-group-clause-group-indicate: 'GROUP' 'INDICATE'?
  | \report-group-clause-source: 'SOURCE' 'IS'? Identifier
  | \report-group-clause-value: 'VALUE' 'IS'? Literal
  // SUM A B UPON DETAIL-1 RESET ON FINAL; several SUM clauses can follow each other, the RESET phrase ends the last
  | \report-group-clause-sum: 'SUM' Identifier+ Upon_phrase? Reset_phrase?
  ;

syntax Line_number
  = \line-number-absolute: Integer
  | \line-number-absolute-next-page: Integer 'ON'? 'NEXT' 'PAGE'
  | \line-number-relative: 'PLUS' Integer
  // COBOL-74
  | \line-number-next-page: 'NEXT' 'PAGE'
  ;

syntax Next_group
  = \next-group-absolute: Integer
  | \next-group-relative: 'PLUS' Integer
  | \next-group-next-page: 'NEXT' 'PAGE'
  ;

syntax Report_group_type
  = \report-group-type-report-heading: 'REPORT' 'HEADING'
  | \report-group-type-report-heading: 'RH'
  | \report-group-type-page-heading: 'PAGE' 'HEADING'
  | \report-group-type-page-heading: 'PH'
  | \report-group-type-control-heading: 'CONTROL' 'HEADING' Control_name
  | \report-group-type-control-heading: 'CH' Control_name
  | \report-group-type-detail: 'DETAIL'
  | \report-group-type-detail: 'DE'
  | \report-group-type-control-footing: 'CONTROL' 'FOOTING' Control_name
  | \report-group-type-control-footing: 'CF' Control_name
  | \report-group-type-page-footing: 'PAGE' 'FOOTING'
  | \report-group-type-page-footing: 'PF'
  | \report-group-type-report-footing: 'REPORT' 'FOOTING'
  | \report-group-type-report-footing: 'RF'
  ;

syntax Control_name
  = \control-name-final: 'FINAL'
  | \control-name: Data_name
  ;

syntax Upon_phrase = \upon-phrase: 'UPON' Data_name+;

syntax Reset_phrase = \reset-phrase: 'RESET' 'ON'? Control_name;

// the special registers, one per report, qualified by the report name when there are several reports
syntax Identifier
  = \identifier-line-counter: 'LINE-COUNTER'
  | \identifier-line-counter: 'LINE-COUNTER' In Report_name
  | \identifier-page-counter: 'PAGE-COUNTER'
  | \identifier-page-counter: 'PAGE-COUNTER' In Report_name
  ;

syntax Statement
  = \statement-initiate: 'INITIATE' Report_name+
  // a report group name (TYPE DETAIL) or a report name (summary reporting)
  | \statement-generate: 'GENERATE' Qualified_data_name
  | \statement-terminate: 'TERMINATE' Report_name+
  // only in a USE BEFORE REPORTING procedure
  | \statement-suppress: 'SUPPRESS' 'PRINTING'?
  ;

syntax Use_statement
  = \use-statement-before-reporting: 'USE' 'GLOBAL'? 'BEFORE' 'REPORTING' Identifier
  ;
