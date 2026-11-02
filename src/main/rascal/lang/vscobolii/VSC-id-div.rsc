module lang::vscobolii::\VSC-id-div

extend lang::vscobolii::\VSC-expr;

syntax Identification_division_content = \identification-division-content: Identification_division_phrase*;
syntax Identification
  = \identification-c2: 'ID'
  | \identification-c1: 'IDENTIFICATION'
  ;
  
lexical MetaDataContentLine
  = Word \ NoIDKeyword ![\n]* [\n]
  // headers start in Area A (columns 8-11), so a comment-entry line in Area B (11 spaces before it, after the
  // preprocessor) can start with a header word, as in `PROCEDURE BUILDS THE EIGHT-RECORD FILE`
  | "           " << NoIDKeyword !>> [a-zA-Z0-9\"()\-] ![\n]* [\n]
  ;

// the first word of a comment-entry line; it stops at a `.`, so `AUTHOR.` is recognized as a paragraph header.
// It does not start with `*` or `/`, because then the line is a comment line (layout).
lexical Word = ![\ \t\n.*/] ![\ \t\n.]* !>> ![\ \t\n.];

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

syntax Identification_division_phrase
  = \identification-division-phrase-c5: 'SECURITY' "."? MetaDataContentLine*
  | \identification-division-phrase-c4: 'DATE-COMPILED' "."? MetaDataContentLine*
  | \identification-division-phrase-c1: 'AUTHOR' "."? MetaDataContentLine*
  | \identification-division-phrase-c3: 'DATE-WRITTEN' "."? MetaDataContentLine*
  | \identification-division-phrase-c6: 'REMARKS' "."? MetaDataContentLine*
  | \identification-division-phrase-c2: 'INSTALLATION' "."? MetaDataContentLine*
  ;