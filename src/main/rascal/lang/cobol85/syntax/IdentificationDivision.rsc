module lang::cobol85::\syntax::IdentificationDivision

extend lang::cobol85::\syntax::Expression;

// the reserved words of this module
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

lexical MetaDataContentLine
    = Word \ NoIDKeyword ![\n]* [\n]
    // headers start in Area A (columns 8-11), so a comment-entry line in Area B (at least 5 spaces before it, after
    // the margin and the indicator column) can start with a header word, as in `PROCEDURE BUILDS THE EIGHT-RECORD FILE`
    | "     " << NoIDKeyword !>> [a-zA-Z0-9\"()\-] ![\n]* [\n]
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
