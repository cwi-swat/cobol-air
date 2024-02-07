 module lang::vscobolii::\VSC-stat  extend lang::vscobolii::\VSC-cond;
extend lang::vscobolii::\VSC-lex;
extend lang::vscobolii::\VSC-expr; 
syntax On_key_phrase =
  \on-key-phrase: 'ON'? Alt_ascending_descending 'KEY'? Qualified_data_name+ 
  ; 
syntax Accept_statement =
   \accept-statement-c1: 'ACCEPT' Identifier 'FROM' Date 
  |  \accept-statement-c2: 'ACCEPT' Identifier
 |  \accept-statement-c2: 'ACCEPT' Identifier 'FROM' Cobword \ CobwordKeywords 
  ; 

syntax EndSearch = 'END-SEARCH' | () >> ".";

syntax Search_statement =
   \search-statement-c2: 'SEARCH' 'ALL' Identifier At_end_statement_list? 'WHEN' Search_statement_condition Search_statement_condition_tail* Alt_statement_list_next_sentence EndSearch
  |  \search-statement-c1: 'SEARCH' Identifier At_end_statement_list? When_condition_stats+ EndSearch
 |  \search-statement-c1: 'SEARCH' Identifier 'VARYING' Identifier  At_end_statement_list? When_condition_stats+ EndSearch
  ; 
syntax Perform_until_phrase =
  \perform-until-phrase: With_test? 'UNTIL' Condition 
  ; 
syntax Search_statement_condition_tail =
  \search-statement-condition-tail: 'AND' Search_statement_condition 
  ;

syntax Procedure_to_procedure =
   \procedure-to-procedure: Procedure_name 'TO' Procedure_name
 |  \procedure-to-procedure: Procedure_name 'TO' 'PROCEED' 'TO'  Procedure_name 
  ;

syntax Delimited_by_phrase =
  \delimited-by-phrase: Id_or_lit+ 'DELIMITED' 'BY'? Id_or_lit_size 
  ; 
syntax Inspect_by_argument =
  \inspect-by-argument-c3: Figurative_constant_simple 
  | \inspect-by-argument-c2: Nonnumeric 
  | \inspect-by-argument-c1: Identifier 
  ; 
syntax Perform_after_phrase =
  \perform-after-phrase: 'AFTER' Identifier 'FROM' Id_or_lit 'BY' Id_or_lit 'UNTIL' Condition 
  ; 
syntax Initialize_replacing_argument =
  \initialize-replacing-argument: Initialize_replacing_type 'DATA'? 'BY' Id_or_lit 
  ; 
syntax Sort_statement_out =
  \sort-statement-out-c1: Giving_file_names 
  | \sort-statement-out-c2: Output_procedure 
  ; 
syntax Collating_sequence =
  \collating-sequence: 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name 
  ;

syntax Before_after_phrase =
  \before-after-phrase: Alt_before_after 'INITIAL'? Id_or_lit 
  ;

syntax Tallying_for_argument =
   \tallying-for-argument-c1: 'CHARACTERS' Before_after_phrase* 
  |  \tallying-for-argument-c2: Alt_all_leading Tallying_for_id_or_lit+ 
  ; 
syntax Alt_file_reel_unit =
  \alt-file-reel-unit-c3: 'UNIT' 
  | \alt-file-reel-unit-c2: 'REEL' 
  | \alt-file-reel-unit-c1: 'FILE' 
  ; 
syntax Lines =
  \lines-c2: 'LINES' 
  | \lines-c1: 'LINE' 
  ; 
syntax Id_or_lit =
  \id-or-lit-c1: Literal 
  | \id-or-lit-c2: Identifier 
  ; 
syntax Evaluate_phrase =
   \evaluate-phrase-c4: 'NOT'? Arithmetic_expression Through Arithmetic_expression 
  | \evaluate-phrase-c2: 'TRUE' 
  | \evaluate-phrase-c5: Condition 
  |  \evaluate-phrase-c6: 'NOT'? Arithmetic_expression 
  | \evaluate-phrase-c3: 'FALSE' 
  | \evaluate-phrase-c1: 'ANY' 
  ; 
syntax Alt_beginning_ending =
  \alt-beginning-ending-c1: 'BEGINNING' 
  | \alt-beginning-ending-c2: 'ENDING' 
  ;

syntax When_phrase =
  \when-phrase: 'WHEN' Evaluate_phrase When_phrase_also_phrase* 
  ; 
syntax From_identifier =
  \from-identifier: 'FROM' Identifier 
  ;

syntax Open_statement_phrase =
   \open-statement-phrase-c3: 'I-O' File_name+ 
  |  \open-statement-phrase-c1: 'INPUT' Open_statement_input_file_name+ 
  |  \open-statement-phrase-c2: 'OUTPUT' Open_statement_output_file_name+ 
  |  \open-statement-phrase-c4: 'EXTEND' File_name+ 
  ;

syntax At_end_statement_list =
  \at-end-statement-list: 'AT'? 'END' Statement_list 
  ;

syntax EndAdd = 'END-ADD'?; //  | () >> ".";

syntax Add_statement =
   \add-statement-c1: 'ADD' Id_or_lit+ 'GIVING' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndAdd
 |  \add-statement-c1: 'ADD' Id_or_lit+ 'TO' Id_or_lit  'GIVING' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndAdd
  |  \add-statement-c3: 'ADD' Corresponding Identifier 'TO' Identifier 'ROUNDED'? On_size_error_statement_list? Not_on_size_error_statement_list? EndAdd
  |  \add-statement-c2: 'ADD' Id_or_lit+ 'TO' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndAdd
  ;

syntax Also_phrase =
  \also-phrase: 'ALSO' Evaluate_condition 
  ;

syntax Through_procedure_name =
  \through-procedure-name: Through Procedure_name 
  ;

syntax Perform_statement =
   \perform-statement-c2: 'PERFORM' Perform_statement_2_alts 
  |  \perform-statement-c3: 'PERFORM' Perform_statement_3_alts 
  |  \perform-statement-c4: 'PERFORM' Perform_statement_1_alts 
  |  \perform-statement-c1: 'PERFORM' Perform_statement_4_alts 
  ; 
syntax Alt_removal_no_rewind =
  \alt-removal-no-rewind-c2: With_no_rewind 
  |  \alt-removal-no-rewind-c1: 'FOR'? 'REMOVAL' 
  ;

syntax Alt_up_down =
  \alt-up-down-c2: 'DOWN' 
  | \alt-up-down-c1: 'UP' 
  ;

syntax When_phrase_also_phrase =
  \when-phrase-also-phrase: 'ALSO' Evaluate_phrase 
  ;

syntax Cobword_int =
  \cobword-int-c1: Identifier 
  | \cobword-int-c2: Integer 
  ; 
syntax Corresponding =
  \corresponding-c2: 'CORR' 
  | \corresponding-c1: 'CORRESPONDING' 
  ;

syntax End_of_page =
  \end-of-page-c1: 'END-OF-PAGE' 
  | \end-of-page-c2: 'EOP' 
  ; 
syntax Inspect_replacing_phrase =
   \inspect-replacing-phrase-c1: 'CHARACTERS' 'BY' Id_or_lit Before_after_phrase* 
  |  \inspect-replacing-phrase-c2: Alt_all_leading_first Inspect_replacing_argument+ 
  ; 
syntax Alt_before_after =
  \alt-before-after-c1: 'BEFORE' 
  | \alt-before-after-c2: 'AFTER' 
  ; 
syntax Alt_all_leading =
  \alt-all-leading-c1: 'ALL' 
  | \alt-all-leading-c2: 'LEADING' 
  ; 
syntax Using_data_name_pluslist =
  \using-data-name-pluslist: 'USING' Data_name+ 
  ;

syntax Not_at_end_statement_list =
  \not-at-end-statement-list: 'NOT' 'AT'? 'END' Statement_list 
  ;

syntax Alt_file_names_i_o =
   \alt-file-names-i-o-c1: File_name+ 
  | \alt-file-names-i-o-c3: 'OUTPUT' 
  | \alt-file-names-i-o-c2: 'INPUT' 
  | \alt-file-names-i-o-c4: 'I-O' 
  | \alt-file-names-i-o-c5: 'EXTEND' 
  ; 
syntax Output_procedure =
  \output-procedure: 'OUTPUT' 'PROCEDURE' 'IS'? Procedure_name Through_procedure_name? 
  ;

syntax Evaluate_condition =
  \evaluate-condition-c3: 'FALSE' 
  | \evaluate-condition-c1: Condition 
  | \evaluate-condition-c2: 'TRUE' 
  ; 
syntax When_phrases =
  \when-phrases: When_phrase+ Statement_list 
  ;

syntax Open_statement_output_file_name =
  \open-statement-output-file-name: File_name With_no_rewind? 
  ;

syntax Content_parameter_value =
  \content-parameter-value-c1: Identifier 
  | \content-parameter-value-c2: Literal 
  ;

syntax Equal =
  \equal-c1: "=" 
  | \equal-c2: 'EQUAL' 
  ; 
syntax Search_statement_condition =
   \search-statement-condition-c1: Identifier 'IS'? Equal_to Arithmetic_expression 
  |  \search-statement-condition-c2: Alphabetic_user_defined_word In_data_or_file_or_mnemonic_name* Subscript_parentheses* 
  ;

syntax EndMultiply = 'END-MULTIPLY'?; // | () >> ".";

syntax Multiply_statement =
   \multiply-statement-c1: 'MULTIPLY' Id_or_lit 'BY' Id_or_lit 'GIVING' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndMultiply
  |  \multiply-statement-c2: 'MULTIPLY' Id_or_lit 'BY' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndMultiply
  ; 
syntax Alt_statement_list_next_sentence =
  \alt-statement-list-next-sentence-c1: Statement_list 
  |  \alt-statement-list-next-sentence-c2: 'NEXT' 'SENTENCE' 
  ;

syntax Open_statement_input_file_name =
  \open-statement-input-file-name: File_name Alt_reversed_with_no_rewind? 
  ; 
syntax Close_statement_file_name =
  \close-statement-file-name: File_name Close_statement_options? 
  ; 
syntax Not_on_overflow_statement_list =
  \not-on-overflow-statement-list: 'NOT' 'ON'? 'OVERFLOW' Statement_list 
  ; 
syntax Initialize_replacing_type =
  \initialize-replacing-type-c1: 'ALPHABETIC' 
  | \initialize-replacing-type-c5: 'NUMERIC-EDITED' 
  | \initialize-replacing-type-c3: 'NUMERIC' 
  | \initialize-replacing-type-c4: 'ALPHANUMERIC-EDITED' 
  | \initialize-replacing-type-c2: 'ALPHANUMERIC' 
  | \initialize-replacing-type-c6: 'DBCS' 
  | \initialize-replacing-type-c7: 'EGCS' 
  ;

syntax Use_statement =
   \use-statement-c1: 'USE' 'GLOBAL'? 'AFTER' 'STANDARD'? Alt_exception_error 'PROCEDURE' 'ON'? Alt_file_names_i_o 
  |  \use-statement-c2: 'USE' 'GLOBAL'? 'AFTER' 'STANDARD'? Alt_beginning_ending? Alt_file_reel_unit? 'LABEL' 'PROCEDURE' 'ON'? Alt_file_names_i_o 
  |  \use-statement-c3: 'USE' 'FOR'? 'DEBUGGING' 'ON'? Alt_procedures_all_procedures 
  ;

syntax Giving_file_names =
  \giving-file-names: 'GIVING' File_name+ 
  ; 
syntax Sort_statement_in =
   \sort-statement-in-c1: 'USING' File_name+ 
  |  \sort-statement-in-c2: 'INPUT' 'PROCEDURE' 'IS'? Procedure_name Through_procedure_name? 
  ;

syntax Invalid_key_statement_list =
  \invalid-key-statement-list: 'INVALID' 'KEY'? Statement_list 
  ; 
syntax When_condition_stats =
  \when-condition-stats: 'WHEN' Condition Alt_statement_list_next_sentence 
  ; 
syntax Inspect_replacing_argument =
  \inspect-replacing-argument: Inspect_by_argument 'BY' Inspect_by_argument Before_after_phrase* 
  ; 
syntax Parameter =
   \parameter-c2: 'BY'? 'CONTENT' Content_parameter_value+ 
  |  \parameter-c1: Identifier
 |  \parameter-c1: 'BY'? 'REFERENCE'  Identifier 
  ;

syntax Page_phrase =
  \page-phrase-c2: 'PAGE' 
  |  \page-phrase-c1: Cobword_int Lines? 
  ; 

syntax EndDivide = 'END-DIVIDE'? ; // | () >> ".";

syntax Divide_statement =
   \divide-statement-c3: 'DIVIDE' Id_or_lit 'INTO' Id_or_lit 'GIVING' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndDivide
  |  \divide-statement-c5: 'DIVIDE' Id_or_lit 'INTO' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndDivide
  |  \divide-statement-c2: 'DIVIDE' Id_or_lit 'BY' Id_or_lit 'GIVING' Identifier 'ROUNDED'? 'REMAINDER' Identifier On_size_error_statement_list? Not_on_size_error_statement_list? EndDivide
  |  \divide-statement-c1: 'DIVIDE' Id_or_lit 'INTO' Id_or_lit 'GIVING' Identifier 'ROUNDED'? 'REMAINDER' Identifier On_size_error_statement_list? Not_on_size_error_statement_list? EndDivide
  |  \divide-statement-c4: 'DIVIDE' Id_or_lit 'BY' Id_or_lit 'GIVING' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndDivide
  ; 
syntax Into_identifier =
  \into-identifier: 'INTO' Identifier 
  ; 
syntax On_overflow_statement_list =
  \on-overflow-statement-list: 'ON'? 'OVERFLOW' Statement_list 
  ;

syntax With_test =
  \with-test: 'WITH'? 'TEST' Alt_before_after 
  ;

syntax Set_oper =
   \set-oper-c2: Alt_up_down 'BY' 
  | \set-oper-c1: 'TO' 
  ; 
syntax If_statement =
  \if-statement: 'IF' Condition 'THEN'? Alt_statement_list_next_sentence () !>> 'ELSE' EndIf
  |  \if-else-statement: 'IF' Condition 'THEN'? Alt_statement_list_next_sentence 'ELSE' Alt_statement_list_next_sentence  EndIf
  ; 

syntax EndIf = 'END-IF' | () >> ".";
syntax EndCompute = 'END-COMPUTE'?; // | () >> ".";
syntax EndCall = 'END-CALL'? ;// | () >> ".";
syntax EndString = 'END-STRING'?; // | () >> ".";
syntax EndDelete = 'END-DELETE' | () >> ".";
syntax EndUnString = 'END-UNSTRING'? ; // | () >> ".";
syntax EndWrite = 'END-WRITE'? ; // | () >> ".";
syntax EndEvaluate = 'END-EVALUATE'? ; // | () >> ".";
syntax EndReturn = 'END-RETURN'? ; // | () >> ".";
syntax EndStart = 'END-START' | () >> ".";
syntax EndRewrite = 'END-REWRITE' | () >> ".";
syntax EndRead = 'END-READ' | () >> ".";


syntax Statement =
   \statement-c18: 'EXIT' 'PROGRAM' 
  |  \statement-c23: 'MERGE' File_name On_key_phrase+ Collating_sequence? 'USING' File_name File_name+ Merge_statement_tail 
  | \statement-c30: Search_statement 
  |  \statement-c11: 'COMPUTE' Cobword_rounded+ Equal Arithmetic_expression On_size_error_statement_list? Not_on_size_error_statement_list? EndCompute
  |  \statement-c19: 'EXIT' 
  |  \statement-c7: 'ALTER' Procedure_to_procedure+ 
  |  \statement-c8: 'CALL' Id_or_lit On_overflow_statement_list?  EndCall
 |  \statement-c8: 'CALL' Id_or_lit 'NOT' 'ON'? 'EXCEPTION' Statement_list  On_overflow_statement_list?  EndCall
 |  \statement-c8: 'CALL' Id_or_lit 'ON'? 'EXCEPTION' Statement_list On_overflow_statement_list?  EndCall
 |  \statement-c8: 'CALL' Id_or_lit 'ON'? 'EXCEPTION' Statement_list 'NOT' 'ON'? 'EXCEPTION' Statement_list  On_overflow_statement_list?  EndCall
 |  \statement-c8: 'CALL' Id_or_lit 'USING' Parameter+ On_overflow_statement_list?  EndCall
 |  \statement-c8: 'CALL' Id_or_lit 'USING' Parameter+ 'NOT' 'ON'? 'EXCEPTION' Statement_list  On_overflow_statement_list?  EndCall
 |  \statement-c8: 'CALL' Id_or_lit 'USING' Parameter+ 'ON'? 'EXCEPTION' Statement_list On_overflow_statement_list?  EndCall
 |  \statement-c8: 'CALL' Id_or_lit 'USING' Parameter+ 'ON'? 'EXCEPTION' Statement_list 'NOT' 'ON'? 'EXCEPTION' Statement_list  On_overflow_statement_list?  EndCall
  |  \statement-c31: 'SET' Set_statement_phrase+ 
  |  \statement-c34: 'STOP' Alt_run_literal 
  | \statement-c15: Divide_statement 
  |  \statement-c14: 'DISPLAY' Id_or_lit+
 |  \statement-c14: 'DISPLAY' Id_or_lit+ 'WITH'? 'NO' 'ADVANCING'
 |  \statement-c14: 'DISPLAY' Id_or_lit+ 'UPON' Cobword \ CobwordKeywords
 |  \statement-c14: 'DISPLAY' Id_or_lit+ 'UPON' Cobword \ CobwordKeywords 'WITH'? 'NO' 'ADVANCING' 
  |  \statement-c26: 'READ' File_name 'NEXT'? 'RECORD'? Into_identifier? Invalid_key_statement_list? Not_invalid_key_statement_list? At_end_statement_list? Not_at_end_statement_list? EndRead
 |  \statement-c26: 'READ' File_name 'NEXT'? 'RECORD'? Into_identifier? 'KEY' 'IS'? Qualified_data_name  Invalid_key_statement_list? Not_invalid_key_statement_list? At_end_statement_list? Not_at_end_statement_list? EndRead
  |  \statement-c35: 'STRING' Delimited_by_phrase+ 'INTO' Identifier With_pointer_identifier? On_overflow_statement_list? Not_on_overflow_statement_list? EndString
  | \statement-c36: Subtract_statement 
  | \statement-c1: Move_statement 
  | \statement-c4: Go_to_statement 
  |  \statement-c20: 'GOBACK' 
  | \statement-c6: Add_statement 
  | \statement-c5: Accept_statement 
  |  \statement-c13: 'DELETE' File_name 'RECORD'? Invalid_key_statement_list? Not_invalid_key_statement_list? EndDelete
  |  \statement-c21: 'INITIALIZE' Identifier+
 |  \statement-c21: 'INITIALIZE' Identifier+ 'REPLACING' Initialize_replacing_argument+ 
  |  \statement-c12: 'CONTINUE' 
  |  \statement-c27: 'RELEASE' Record_name From_identifier? 
  |  \statement-c37: 'UNSTRING' Identifier 'INTO' Unstring_statement_dst+ With_pointer_identifier? On_overflow_statement_list? Not_on_overflow_statement_list? EndUnString
 |  \statement-c37: 'UNSTRING' Identifier 'INTO' Unstring_statement_dst+ With_pointer_identifier? 'TALLYING' 'IN'? Identifier  On_overflow_statement_list? Not_on_overflow_statement_list? EndUnString
 |  \statement-c37: 'UNSTRING' Identifier 'DELIMITED' 'BY'? 'ALL'? Id_or_lit Or_all_id_or_lit*  'INTO' Unstring_statement_dst+ With_pointer_identifier? On_overflow_statement_list? Not_on_overflow_statement_list? EndUnString
 |  \statement-c37: 'UNSTRING' Identifier 'DELIMITED' 'BY'? 'ALL'? Id_or_lit Or_all_id_or_lit*  'INTO' Unstring_statement_dst+ With_pointer_identifier? 'TALLYING' 'IN'? Identifier  On_overflow_statement_list? Not_on_overflow_statement_list? EndUnString
  |  \statement-c10: 'CLOSE' Close_statement_file_name+ 
  | \statement-c2: If_statement 
  | \statement-c22: Inspect_statement 
  |  \statement-c32: 'SORT' File_name On_key_is_phrase+ Collating_sequence? Sort_statement_in Sort_statement_out
  |  \statement-c32: 'SORT' File_name On_key_is_phrase+ 'WITH'? 'DUPLICATES' 'IN'? 'ORDER'?  Collating_sequence? Sort_statement_in Sort_statement_out 
  |  \statement-c38: 'WRITE' Record_name From_identifier? Invalid_key_statement_list? Not_invalid_key_statement_list?  EndWrite
  |  \statement-c38: 'WRITE' Record_name From_identifier? 'NOT' 'AT'? End_of_page Statement_list  Invalid_key_statement_list? Not_invalid_key_statement_list?  EndWrite
  |  \statement-c38: 'WRITE' Record_name From_identifier? 'AT'? End_of_page Statement_list Invalid_key_statement_list? Not_invalid_key_statement_list?  EndWrite
  |  \statement-c38: 'WRITE' Record_name From_identifier? 'AT'? End_of_page Statement_list 'NOT' 'AT'? End_of_page Statement_list  Invalid_key_statement_list? Not_invalid_key_statement_list?  EndWrite
  |  \statement-c38: 'WRITE' Record_name From_identifier? Alt_before_after 'ADVANCING'? Page_phrase Invalid_key_statement_list? Not_invalid_key_statement_list?  EndWrite
  |  \statement-c38: 'WRITE' Record_name From_identifier? Alt_before_after 'ADVANCING'? Page_phrase 'NOT' 'AT'? End_of_page Statement_list  Invalid_key_statement_list? Not_invalid_key_statement_list?  EndWrite
  |  \statement-c38: 'WRITE' Record_name From_identifier? Alt_before_after 'ADVANCING'? Page_phrase 'AT'? End_of_page Statement_list Invalid_key_statement_list? Not_invalid_key_statement_list?  EndWrite
  |  \statement-c38: 'WRITE' Record_name From_identifier? Alt_before_after 'ADVANCING'? Page_phrase 'AT'? End_of_page Statement_list 'NOT' 'AT'? End_of_page Statement_list  Invalid_key_statement_list? Not_invalid_key_statement_list?  EndWrite
  |  \statement-c17: 'EVALUATE' Evaluate_condition Also_phrase* When_phrases+ EndEvaluate
  |  \statement-c17: 'EVALUATE' Evaluate_condition Also_phrase* When_phrases+ 'WHEN' 'OTHER' Statement_list  EndEvaluate
  |  \statement-c33: 'START' File_name Invalid_key_statement_list? Not_invalid_key_statement_list? EndStart
  |  \statement-c33: 'START' File_name 'KEY' 'IS'? Rel_op Qualified_data_name  Invalid_key_statement_list? Not_invalid_key_statement_list? EndStart
  |  \statement-c28: 'RETURN' File_name 'RECORD'? Into_identifier? 'AT'? 'END' Statement_list Not_at_end_statement_list? EndReturn
  | \statement-c3: Perform_statement 
  |  \statement-c16: 'ENTRY' Literal Using_data_name_pluslist? 
  |  \statement-c9: 'CANCEL' Id_or_lit+ 
  |  \statement-c25: 'OPEN' Open_statement_phrase+ 
  | \statement-c24: Multiply_statement 
  |  \statement-c29: 'REWRITE' Record_name From_identifier? Invalid_key_statement_list? Not_invalid_key_statement_list? EndRewrite
  ;


syntax Not_on_size_error_statement_list =
  \not-on-size-error-statement-list: 'NOT' 'ON'? 'SIZE' 'ERROR' Statement_list 
  ; 
syntax On_key_is_phrase =
   \on-key-is-phrase: 'ON'? Alt_ascending_descending Qualified_data_name+
 |  \on-key-is-phrase: 'ON'? Alt_ascending_descending 'KEY' 'IS'?  Qualified_data_name+ 
  ;

syntax Date =
  \date-c4: 'TIME' 
  | \date-c2: 'DAY' 
  | \date-c1: 'DATE' 
  | \date-c3: 'DAY-OF-WEEK' 
  ; 
syntax Cobword_rounded =
  \cobword-rounded: Identifier 'ROUNDED'? 
  ;

syntax Statement_list =
  \statement-list: Statement+ 
  ; 
syntax Move_statement =
   \move-statement-c2: 'MOVE' Corresponding Identifier 'TO' Identifier+ 
  |  \move-statement-c1: 'MOVE' Id_or_lit 'TO' Identifier+ 
  ;

syntax Id_or_lit_size =
  \id-or-lit-size-c1: Literal 
  | \id-or-lit-size-c3: 'SIZE' 
  | \id-or-lit-size-c2: Identifier 
  ; 
syntax Unstring_statement_dst =
   \unstring-statement-dst: Identifier
 |  \unstring-statement-dst: Identifier 'COUNT' 'IN'? Identifier
 |  \unstring-statement-dst: Identifier 'DELIMITER' 'IN'? Identifier
 |  \unstring-statement-dst: Identifier 'DELIMITER' 'IN'? Identifier 'COUNT' 'IN'? Identifier 
  ; 
syntax With_no_rewind =
  \with-no-rewind: 'WITH'? 'NO' 'REWIND' 
  ;

syntax Tallying_for_id_or_lit =
  \tallying-for-id-or-lit: Id_or_lit Before_after_phrase* 
  ; 
syntax Perform_statement_4_alts =
   \perform-statement-4-alts-c2: Perform_until_phrase Statement_list 'END-PERFORM' 
  |  \perform-statement-4-alts-c1: Procedure_name Through_procedure_name? Perform_until_phrase 
  ;

syntax On_size_error_statement_list =
  \on-size-error-statement-list: 'ON'? 'SIZE' 'ERROR' Statement_list 
  ; 
syntax Alt_all_leading_first =
  \alt-all-leading-first-c1: 'ALL' 
  | \alt-all-leading-first-c3: 'FIRST' 
  | \alt-all-leading-first-c2: 'LEADING' 
  ;

syntax Alt_exception_error =
  \alt-exception-error-c1: 'EXCEPTION' 
  | \alt-exception-error-c2: 'ERROR' 
  ;

syntax Not_invalid_key_statement_list =
  \not-invalid-key-statement-list: 'NOT' 'INVALID' 'KEY'? Statement_list 
  ;

syntax Go_to_statement =
   \go-to-statement-c3: 'GO' 'TO'? 'MORE-LABELS' 
  |  \go-to-statement-c2: 'GO' 'TO'? Procedure_name 
  |  \go-to-statement-c1: 'GO' 'TO'? Procedure_name+ 'DEPENDING' 'ON'? Identifier 
  ; 
syntax Or_all_id_or_lit =
  \or-all-id-or-lit: 'OR' 'ALL'? Id_or_lit 
  ; 
syntax Alt_run_literal =
  \alt-run-literal-c1: 'RUN' 
  | \alt-run-literal-c2: Literal 
  ; 
syntax Perform_statement_2_alts =
   \perform-statement-2-alts-c1: Procedure_name Through_procedure_name? Perform_varying_phrase Perform_after_phrase* 
  |  \perform-statement-2-alts-c2: Perform_varying_phrase Statement_list 'END-PERFORM' 
  ; 
syntax With_pointer_identifier =
  \with-pointer-identifier: 'WITH'? 'POINTER' Identifier 
  ; 

syntax EndSubstract = 'END-SUBSTRACT'?; // | () >> ".";

syntax Subtract_statement =
   \subtract-statement-c2: 'SUBTRACT' Id_or_lit+ 'FROM' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndSubstract
  |  \subtract-statement-c1: 'SUBTRACT' Id_or_lit+ 'FROM' Id_or_lit 'GIVING' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndSubstract
  |  \subtract-statement-c3: 'SUBTRACT' Corresponding Identifier 'FROM' Identifier 'ROUNDED'? On_size_error_statement_list? Not_on_size_error_statement_list? EndSubstract
  ; 


syntax Inspect_statement =
   \inspect-statement-c1: 'INSPECT' Identifier 'TALLYING' Tallying_argument+ 'REPLACING' Inspect_replacing_phrase+ 
  |  \inspect-statement-c4: 'INSPECT' Identifier 'REPLACING' Inspect_replacing_phrase+ 
  |  \inspect-statement-c3: 'INSPECT' Identifier 'CONVERTING' Id_or_lit 'TO' Id_or_lit Before_after_phrase* 
  |  \inspect-statement-c2: 'INSPECT' Identifier 'TALLYING' Tallying_argument+ 
  ; 
syntax Perform_statement_3_alts =
   \perform-statement-3-alts-c1: Procedure_name Through_procedure_name? Cobword_int 'TIMES' 
  |  \perform-statement-3-alts-c2: Cobword_int 'TIMES' Statement_list 'END-PERFORM' 
  ;

syntax Rel_op =
  \rel-op-c1: Equal_to 
  | \rel-op-c2: Greater_than_or_equal_to 
  | \rel-op-c3: Greater_than 
  ; 
syntax Alt_no_rewind_lock =
   \alt-no-rewind-lock-c1: 'NO' 'REWIND' 
  | \alt-no-rewind-lock-c2: 'LOCK' 
  ; 
syntax Close_statement_options =
   \close-statement-options-c2: 'WITH'? Alt_no_rewind_lock 
  |  \close-statement-options-c1: Alt_reel_unit Alt_removal_no_rewind? 
  ;

syntax Set_src =
  \set-src-c5: 'OFF' 
  | \set-src-c1: Identifier 
  | \set-src-c2: Literal 
  | \set-src-c4: 'ON' 
  | \set-src-c3: 'TRUE' 
  ;

syntax Alt_procedures_all_procedures =
   \alt-procedures-all-procedures-c2: 'ALL' 'PROCEDURES' 
  |  \alt-procedures-all-procedures-c1: Procedure_name+ 
  ;

syntax Alt_reversed_with_no_rewind =
  \alt-reversed-with-no-rewind-c1: 'REVERSED' 
  | \alt-reversed-with-no-rewind-c2: With_no_rewind 
  ;

syntax Merge_statement_tail =
  \merge-statement-tail-c1: Output_procedure 
  | \merge-statement-tail-c2: Giving_file_names 
  ; 
syntax Perform_statement_1_alts =
   \perform-statement-1-alts-c1: Procedure_name Through_procedure_name? 
  |  \perform-statement-1-alts-c2: Statement_list 'END-PERFORM' 
  ;

syntax Set_statement_phrase =
  \set-statement-phrase: Identifier+ Set_oper Set_src 
  ;

syntax Tallying_argument =
  \tallying-argument: Identifier 'FOR' Tallying_for_argument+ 
  ; 
syntax Perform_varying_phrase =
  \perform-varying-phrase: With_test? 'VARYING' Identifier 'FROM' Id_or_lit 'BY' Id_or_lit 'UNTIL' Condition 
  ;
