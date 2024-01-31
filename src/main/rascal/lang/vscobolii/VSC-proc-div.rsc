module lang::vscobolii::\VSC-proc-div 

extend lang::vscobolii::\VSC-stat;
extend lang::vscobolii::\VSC-expr;


syntax Procedure_division =
  \procedure-division: "PROCEDURE" !>> [\- 0-9 A-Z _ a-z] "DIVISION" !>> [\- 0-9 A-Z _ a-z] Using_phrase Declaratives? Sections 
  ;

syntax Sentence_1 =
  \sentence-1: Statement_list "."+ 
  ;

syntax Using_phrase =
  \using-phrase-c2: Using_phrase_2 
  | \using-phrase-c1: Using_phrase_1 
  ;

syntax Sentence_2 =
  \sentence-2: Statement_list? Copy_statement 
  ;

syntax Declaratives =
  declaratives: "DECLARATIVES" !>> [\- 0-9 A-Z _ a-z] "." Declaratives_content+ "END" !>> [\- 0-9 A-Z _ a-z] "DECLARATIVES" !>> [\- 0-9 A-Z _ a-z] "." 
  ;

syntax Altered_goto =
  \altered-goto: Paragraph_name "." "GO" !>> [\- 0-9 A-Z _ a-z] "TO"? "." 
  ;

syntax Section_with_header =
  \section-with-header: Section_header "." Paragraphs 
  ;

syntax Paragraph_1 =
  \paragraph-1: Paragraph_name "." Sentence* 
  ;

syntax Paragraphs =
  paragraphs: Sentence* Paragraph* 
  ;

syntax Using_phrase_1 =
  \using-phrase-1: Using_data_name_pluslist? "." 
  ;

syntax Sections =
  sections: Paragraphs Section_with_header* 
  ;

syntax Paragraph =
  \paragraph-c2: Paragraph_1 
  | \paragraph-c1: Altered_goto 
  ;

syntax Using_data_names =
  \using-data-names: "USING" !>> [\- 0-9 A-Z _ a-z] Data_name* 
  ;

syntax Sentence =
  \sentence-c1: Sentence_1 
  | \sentence-c2: Sentence_2 
  ;

syntax Declaratives_content =
  \declaratives-content: Section_header "." Use_statement "." Paragraphs 
  ;

syntax Section_header =
  \section-header: Section_name "SECTION" !>> [\- 0-9 A-Z _ a-z] Priority_number? 
  ;

syntax Using_phrase_2 =
  \using-phrase-2: Using_data_names? Copy_statement 
  ;
