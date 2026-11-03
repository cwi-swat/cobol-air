module lang::cobol85::\syntax::ProcedureDivision

extend lang::cobol85::\syntax::Statement;
extend lang::cobol85::\syntax::Expression;

// the reserved words of this module
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

syntax Procedure_division
  = procedureDivision: 'PROCEDURE' 'DIVISION' Using_phrase Paragraphs Section_with_header*
  | procedureDivision: 'PROCEDURE' 'DIVISION' Using_phrase 'DECLARATIVES' "." Declaratives_content+ 'END' 'DECLARATIVES' "." Paragraphs Section_with_header*
  ;
syntax Using_phrase
  = copy: Copy_statement
  | copy: 'USING' Data_name* Copy_statement
  | using: Using_data_name_pluslist? "."
  ;
syntax Section_with_header = sectionHeader: Section_header "." Paragraphs;
syntax Paragraphs = items: Paragraph_item* Paragraph*;
syntax Paragraph
  = items: Paragraph_name "." Paragraph_item*
  | go: Paragraph_name "." 'GO' 'TO'? "."
  ;
syntax Paragraph_item
  = sentence: Sentence
  | replaceDirective: Replace_directive
  ;
syntax Sentence
  = statementList: Statement_list "."+
  | copy: Statement_list? Copy_statement
  ;

syntax Declaratives_content = sectionHeader: Section_header "." Use_statement "." Paragraphs;

syntax Section_header = section: Section_name 'SECTION' Priority_number?;