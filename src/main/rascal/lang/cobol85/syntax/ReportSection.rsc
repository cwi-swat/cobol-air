module lang::cobol85::\syntax::ReportSection

// The Report Writer: the REPORT clause of FD entries, the REPORT SECTION with RD entries and report group
// descriptions, the INITIATE, GENERATE, TERMINATE and SUPPRESS statements, USE BEFORE REPORTING, and the
// LINE-COUNTER and PAGE-COUNTER special registers.
//
// This feature is not part of VS COBOL II. It was part of COBOL-68 and COBOL-74 (and IBM's OS/VS COBOL), and
// is the optional Report Writer module of COBOL-85 (ANSI X3.23-1985), which this module follows. VS COBOL II
// dropped it; IBM offered a separate Report Writer precompiler instead. COBOL 2002 added more clauses
// (e.g. OCCURS and PRESENT WHEN in report groups) that are not included here.

extend lang::cobol85::\syntax::DataDivision;
extend lang::cobol85::\syntax::Statement;

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

syntax Report_name = dataName: Data_name;

// FD PRINT-FILE REPORT IS SALES-REPORT.
syntax File_and_sort_description_entry_clause
  = report: 'REPORT' 'IS'? Report_name+
  | report: 'REPORTS' 'ARE'? Report_name+
  ;

// the records of a report file are described by its report groups, so its FD has no record descriptions
syntax File_section_entry
  = reportFd: Alt_fd_sd File_name File_and_sort_description_entry_clause* "."
  ;

// the REPORT SECTION is the last section of the data division
syntax Data_division = reportSection: Data_division Report_section;

syntax Report_section = reportSection: 'REPORT' 'SECTION' "." Report_description*;

syntax Report_description
  = rd: 'RD' Report_name Report_description_clause* "." Report_group_description_entry*
  ;

syntax Report_description_clause
  = globalClause: Global_clause
  | code: 'CODE' 'IS'? Literal
  | control: 'CONTROL' 'IS'? Control_names
  | control: 'CONTROLS' 'ARE'? Control_names
  // PAGE LIMIT IS 60 LINES HEADING 1 FIRST DETAIL 5 LAST DETAIL 55 FOOTING 58
  | page: 'PAGE' Page_limit? Integer Alt_line_lines? Page_phrase*
  ;

// the control data names, from the most to the least major
syntax Control_names
  = final: 'FINAL' Data_name*
  | dataName: Data_name+
  ;

syntax Page_limit
  = limit: 'LIMIT' 'IS'?
  | limit: 'LIMITS' 'ARE'?
  ;

syntax Alt_line_lines
  = line: 'LINE'
  | lines: 'LINES'
  ;

// COBOL-85 fixes the order HEADING, FIRST DETAIL, LAST DETAIL, FOOTING; compilers accept any order
syntax Page_phrase
  = heading: 'HEADING' 'IS'? Integer
  | first: 'FIRST' 'DETAIL' 'IS'? Integer
  | last: 'LAST' 'DETAIL' 'IS'? Integer
  | footing: 'FOOTING' 'IS'? Integer
  ;

// The three formats of the standard (a report group with TYPE at level 01, a group, and an elementary item)
// share one list of clauses, in any order.
syntax Report_group_description_entry
  = // the follow restriction ensures that digits are eaten up by picture strings (as in Data_description_entry)
    entry: Nat !>> [.,] Alt_data_name_filler? Report_group_clause* "."
  | copy: Copy_statement
  ;

syntax Report_group_clause
  = line: 'LINE' 'NUMBER'? 'IS'? Line_number
  | next: 'NEXT' 'GROUP' 'IS'? Next_group
  | \type: 'TYPE' 'IS'? Report_group_type
  | usage: Usage
  | usage: 'USAGE' 'IS'? Usage
  | picture: Picture 'IS'? Picture_string
  | sign: 'SIGN' 'IS'? Alt_leading_trailing 'SEPARATE' 'CHARACTER'?
  | sign: Alt_leading_trailing 'SEPARATE' 'CHARACTER'?
  | justified: Justified 'RIGHT'?
  | blank: 'BLANK' 'WHEN'? Zeroes
  | column: 'COLUMN' 'NUMBER'? 'IS'? Integer
  | group: 'GROUP' 'INDICATE'?
  | source: 'SOURCE' 'IS'? Identifier
  | \value: 'VALUE' 'IS'? Literal
  // SUM A B UPON DETAIL-1 RESET ON FINAL; several SUM clauses can follow each other, the RESET phrase ends the last
  | sum: 'SUM' Identifier+ Upon_phrase? Reset_phrase?
  ;

syntax Line_number
  = integer: Integer
  | integerNextPage: Integer 'ON'? 'NEXT' 'PAGE'
  | plus: 'PLUS' Integer
  // COBOL-74
  | nextPage: 'NEXT' 'PAGE'
  ;

syntax Next_group
  = integer: Integer
  | plus: 'PLUS' Integer
  | nextPage: 'NEXT' 'PAGE'
  ;

syntax Report_group_type
  = reportHeading: 'REPORT' 'HEADING'
  | reportHeading: 'RH'
  | pageHeading: 'PAGE' 'HEADING'
  | pageHeading: 'PH'
  | controlHeading: 'CONTROL' 'HEADING' Control_name
  | controlHeading: 'CH' Control_name
  | detail: 'DETAIL'
  | detail: 'DE'
  | controlFooting: 'CONTROL' 'FOOTING' Control_name
  | controlFooting: 'CF' Control_name
  | pageFooting: 'PAGE' 'FOOTING'
  | pageFooting: 'PF'
  | reportFooting: 'REPORT' 'FOOTING'
  | reportFooting: 'RF'
  ;

syntax Control_name
  = final: 'FINAL'
  | dataName: Data_name
  ;

syntax Upon_phrase = upon: 'UPON' Data_name+;

syntax Reset_phrase = reset: 'RESET' 'ON'? Control_name;

// the special registers, one per report, qualified by the report name when there are several reports
syntax Identifier
  = lineCounter: 'LINE-COUNTER'
  | lineCounter: 'LINE-COUNTER' In Report_name
  | pageCounter: 'PAGE-COUNTER'
  | pageCounter: 'PAGE-COUNTER' In Report_name
  ;

syntax Statement
  = initiate: 'INITIATE' Report_name+
  // a report group name (TYPE DETAIL) or a report name (summary reporting)
  | generate: 'GENERATE' Qualified_data_name
  | terminate: 'TERMINATE' Report_name+
  // only in a USE BEFORE REPORTING procedure
  | suppress: 'SUPPRESS' 'PRINTING'?
  ;

syntax Use_statement
  = useBefore: 'USE' 'GLOBAL'? 'BEFORE' 'REPORTING' Identifier
  ;
