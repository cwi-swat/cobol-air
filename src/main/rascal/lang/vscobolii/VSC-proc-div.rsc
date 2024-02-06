 module lang::vscobolii::\VSC-proc-div  extend lang::vscobolii::\VSC-stat;
extend lang::vscobolii::\VSC-expr;


syntax Procedure_division =
   \procedure-division: 'PROCEDURE' 'DIVISION' Using_phrase Paragraphs Section_with_header*
 |  \procedure-division: 'PROCEDURE' 'DIVISION' Using_phrase 'DECLARATIVES' "." Declaratives_content+ 'END' 'DECLARATIVES' "."  Paragraphs Section_with_header* 
  ; 
syntax Using_phrase =
   \using-phrase-c2: Copy_statement
 |  \using-phrase-c2: 'USING' Data_name*  Copy_statement 
  |  \using-phrase-c1: Using_data_name_pluslist? "." 
  ; 
syntax Section_with_header =
  \section-with-header: Section_header "." Paragraphs 
  ; 
syntax Paragraphs =
  paragraphs: Sentence* Paragraph* 
  ; 
syntax Paragraph =
   \paragraph-c2: Paragraph_name "." Sentence* 
  |  \paragraph-c1: Paragraph_name "." 'GO' 'TO'? "." 
  ; 
syntax Sentence =
   \sentence-c1: Statement_list "."+ 
  |  \sentence-c2: Statement_list? Copy_statement 
  ;

syntax Declaratives_content =
  \declaratives-content: Section_header "." Use_statement "." Paragraphs 
  ;

syntax Section_header =
  \section-header: Section_name 'SECTION' Priority_number? 
  ;
