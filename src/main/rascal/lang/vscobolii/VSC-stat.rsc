module lang::vscobolii::\VSC-stat 


extend lang::vscobolii::\VSC-cond;
extend lang::vscobolii::\VSC-lex;
extend lang::vscobolii::\VSC-expr;


syntax Close_statement_options_1 =
  \close-statement-options-1: Alt_reel_unit Alt_removal_no_rewind? 
  ;

syntax Inspect_statement_4 =
  \inspect-statement-4: 'INSPECT' Identifier 'REPLACING' Inspect_replacing_phrase+ 
  ;

syntax Advancing_phrase =
  \advancing-phrase: Alt_before_after 'ADVANCING'? Page_phrase 
  ;

syntax On_key_phrase =
  \on-key-phrase: 'ON'? Alt_ascending_descending 'KEY'? Qualified_data_name+ 
  ;

syntax Perform_statement_3_procedure =
  \perform-statement-3-procedure: Procedure_name Through_procedure_name? Cobword_int 'TIMES' 
  ;

syntax Delimited_by_all_phrase =
  \delimited-by-all-phrase: 'DELIMITED' 'BY'? 'ALL'? Id_or_lit Or_all_id_or_lit* 
  ;

syntax No_rewind =
  \no-rewind: 'NO' 'REWIND' 
  ;

syntax Accept_statement =
  \accept-statement-c1: Accept_statement_2 
  | \accept-statement-c2: Accept_statement_1 
  ;

syntax Varying_identifier =
  \varying-identifier: 'VARYING' Identifier 
  ;

syntax Search_statement =
  \search-statement-c2: Search_statement_2 
  | \search-statement-c1: Search_statement_1 
  ;

syntax Inspect_statement_3 =
  \inspect-statement-3: 'INSPECT' Identifier 'TALLYING' Tallying_argument+ 'REPLACING' Inspect_replacing_phrase+ 
  ;

syntax Perform_until_phrase =
  \perform-until-phrase: With_test? 'UNTIL' Condition 
  ;

syntax Perform_statement_2_procedure =
  \perform-statement-2-procedure: Procedure_name Through_procedure_name? Perform_varying_phrase Perform_after_phrase* 
  ;

syntax Subtract_statement_3 =
  \subtract-statement-3: 'SUBTRACT' Corresponding Identifier 'FROM' Identifier 'ROUNDED'? On_size_error_statement_list? Not_on_size_error_statement_list? 'END-SUBTRACT'? 
  ;

syntax Delete_statement =
  \delete-statement: 'DELETE' File_name 'RECORD'? Invalid_key_statement_list? Not_invalid_key_statement_list? 'END-DELETE'? 
  ;

syntax Divide_statement_1 =
  \divide-statement-1: 'DIVIDE' Id_or_lit 'INTO' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? 'END-DIVIDE'? 
  ;

syntax To_id_or_lit =
  \to-id-or-lit: 'TO' Id_or_lit 
  ;

syntax Search_statement_condition_tail =
  \search-statement-condition-tail: 'AND' Search_statement_condition 
  ;

syntax Procedure_to_procedure =
  \procedure-to-procedure: Procedure_name 'TO' Proceed_to? Procedure_name 
  ;

syntax Delimited_by_phrase =
  \delimited-by-phrase: Id_or_lit+ 'DELIMITED' 'BY'? Id_or_lit_size 
  ;

syntax Unstring_statement =
  \unstring-statement: 'UNSTRING' Identifier Delimited_by_all_phrase? 'INTO' Unstring_statement_dst+ With_pointer_identifier? Tallying_in_identifier? On_overflow_statement_list? Not_on_overflow_statement_list? 'END-UNSTRING'? 
  ;

syntax Key_is_rel_op_qualified_data_name =
  \key-is-rel-op-qualified-data-name: 'KEY' 'IS'? Rel_op Qualified_data_name 
  ;

syntax Perform_statement_4_procedure =
  \perform-statement-4-procedure: Procedure_name Through_procedure_name? Perform_until_phrase 
  ;

syntax Close_statement_options_2 =
  \close-statement-options-2: 'WITH'? Alt_no_rewind_lock 
  ;

syntax Inspect_by_argument =
  \inspect-by-argument-c3: Figurative_constant_simple 
  | \inspect-by-argument-c2: Nonnumeric 
  | \inspect-by-argument-c1: Identifier 
  ;

syntax With_no_advancing =
  \with-no-advancing: 'WITH'? 'NO' 'ADVANCING' 
  ;

syntax Perform_after_phrase =
  \perform-after-phrase: 'AFTER' Identifier 'FROM' Id_or_lit 'BY' Id_or_lit 'UNTIL' Condition 
  ;

syntax Tallying_in_identifier =
  \tallying-in-identifier: 'TALLYING' 'IN'? Identifier 
  ;

syntax Open_statement =
  \open-statement: 'OPEN' Open_statement_phrase+ 
  ;

syntax Initialize_replacing_argument =
  \initialize-replacing-argument: Initialize_replacing_type 'DATA'? 'BY' Id_or_lit 
  ;

syntax Not_at_end_of_page_statement_list =
  \not-at-end-of-page-statement-list: 'NOT' 'AT'? End_of_page Statement_list 
  ;

syntax Sort_statement_out =
  \sort-statement-out-c1: Giving_file_names 
  | \sort-statement-out-c2: Output_procedure 
  ;

syntax Divide_statement_3 =
  \divide-statement-3: 'DIVIDE' Id_or_lit 'BY' Id_or_lit 'GIVING' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? 'END-DIVIDE'? 
  ;

syntax Collating_sequence =
  \collating-sequence: 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name 
  ;

syntax Before_after_phrase =
  \before-after-phrase: Alt_before_after 'INITIAL'? Id_or_lit 
  ;

syntax Tallying_for_argument =
  \tallying-for-argument-c1: Tallying_for_argument_1 
  | \tallying-for-argument-c2: Tallying_for_argument_2 
  ;

syntax Rewrite_statement =
  \rewrite-statement: 'REWRITE' Record_name From_identifier? Invalid_key_statement_list? Not_invalid_key_statement_list? 'END-REWRITE'? 
  ;

syntax Alt_file_reel_unit =
  \alt-file-reel-unit-c3: 'UNIT' 
  | \alt-file-reel-unit-c2: 'REEL' 
  | \alt-file-reel-unit-c1: 'FILE' 
  ;

syntax Upon_environment_name =
  \upon-environment-name: 'UPON' Cobword \ CobwordKeywords 
  ;

syntax Divide_statement_2 =
  \divide-statement-2: 'DIVIDE' Id_or_lit 'INTO' Id_or_lit 'GIVING' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? 'END-DIVIDE'? 
  ;

syntax Procedure_names =
  \procedure-names: Procedure_name+ 
  ;

syntax Goback_statement =
  \goback-statement: 'GOBACK' 
  ;

syntax Lines =
  \lines-c2: 'LINES' 
  | \lines-c1: 'LINE' 
  ;

syntax Open_statement_extend =
  \open-statement-extend: 'EXTEND' File_name+ 
  ;

syntax Id_or_lit =
  \id-or-lit-c1: Literal 
  | \id-or-lit-c2: Identifier 
  ;

syntax Else_phrase =
  \else-phrase: 'ELSE' Alt_statement_list_next_sentence 
  ;

syntax Evaluate_phrase =
  \evaluate-phrase-c4: Evaluate_phrase_2 
  | \evaluate-phrase-c2: 'TRUE' 
  | \evaluate-phrase-c5: Condition 
  | \evaluate-phrase-c6: Evaluate_phrase_1 
  | \evaluate-phrase-c3: 'FALSE' 
  | \evaluate-phrase-c1: 'ANY' 
  ;

syntax Divide_statement_5 =
  \divide-statement-5: 'DIVIDE' Id_or_lit 'BY' Id_or_lit 'GIVING' Identifier 'ROUNDED'? 'REMAINDER' Identifier On_size_error_statement_list? Not_on_size_error_statement_list? 'END-DIVIDE'? 
  ;

syntax Alt_beginning_ending =
  \alt-beginning-ending-c1: 'BEGINNING' 
  | \alt-beginning-ending-c2: 'ENDING' 
  ;

syntax When_phrase =
  \when-phrase: 'WHEN' Evaluate_phrase When_phrase_also_phrase* 
  ;

syntax Divide_statement_4 =
  \divide-statement-4: 'DIVIDE' Id_or_lit 'INTO' Id_or_lit 'GIVING' Identifier 'ROUNDED'? 'REMAINDER' Identifier On_size_error_statement_list? Not_on_size_error_statement_list? 'END-DIVIDE'? 
  ;

syntax All_procedures =
  \all-procedures: 'ALL' 'PROCEDURES' 
  ;

syntax On_exception_statement_list =
  \on-exception-statement-list: 'ON'? 'EXCEPTION' Statement_list 
  ;

syntax Input_procedure =
  \input-procedure: 'INPUT' 'PROCEDURE' 'IS'? Procedure_name Through_procedure_name? 
  ;

syntax From_identifier =
  \from-identifier: 'FROM' Identifier 
  ;

syntax Open_statement_phrase =
  \open-statement-phrase-c3: Open_statement_i_o 
  | \open-statement-phrase-c1: Open_statement_input 
  | \open-statement-phrase-c2: Open_statement_output 
  | \open-statement-phrase-c4: Open_statement_extend 
  ;

syntax At_end_statement_list =
  \at-end-statement-list: 'AT'? 'END' Statement_list 
  ;

syntax Add_statement =
  \add-statement-c1: Add_statement_2 
  | \add-statement-c3: Add_statement_3 
  | \add-statement-c2: Add_statement_1 
  ;

syntax Also_phrase =
  \also-phrase: 'ALSO' Evaluate_condition 
  ;

syntax Through_procedure_name =
  \through-procedure-name: Through Procedure_name 
  ;

syntax Perform_statement =
  \perform-statement-c2: Perform_statement_2 
  | \perform-statement-c3: Perform_statement_3 
  | \perform-statement-c4: Perform_statement_1 
  | \perform-statement-c1: Perform_statement_4 
  ;

syntax Evaluate_phrase_1 =
  \evaluate-phrase-1: 'NOT'? Arithmetic_expression 
  ;

syntax Alt_removal_no_rewind =
  \alt-removal-no-rewind-c2: With_no_rewind 
  | \alt-removal-no-rewind-c1: For_removal 
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

syntax Move_statement_1 =
  \move-statement-1: 'MOVE' Id_or_lit 'TO' Identifier+ 
  ;

syntax Corresponding =
  \corresponding-c2: 'CORR' 
  | \corresponding-c1: 'CORRESPONDING' 
  ;

syntax End_of_page =
  \end-of-page-c1: 'END-OF-PAGE' 
  | \end-of-page-c2: 'EOP' 
  ;

syntax Count_in_identifier =
  \count-in-identifier: 'COUNT' 'IN'? Identifier 
  ;

syntax Exit_program_statement =
  \exit-program-statement: 'EXIT' 'PROGRAM' 
  ;

syntax Inspect_replacing_phrase =
  \inspect-replacing-phrase-c1: Inspect_replacing_phrase_1 
  | \inspect-replacing-phrase-c2: Inspect_replacing_phrase_2 
  ;

syntax Not_on_exception_statement_list =
  \not-on-exception-statement-list: 'NOT' 'ON'? 'EXCEPTION' Statement_list 
  ;

syntax Display_statement =
  \display-statement: 'DISPLAY' Id_or_lit+ Upon_environment_name? With_no_advancing? 
  ;

syntax Stop_statement =
  \stop-statement: 'STOP' Alt_run_literal 
  ;

syntax With_duplicates_in_order =
  \with-duplicates-in-order: 'WITH'? 'DUPLICATES' 'IN'? 'ORDER'? 
  ;

syntax Alt_before_after =
  \alt-before-after-c1: 'BEFORE' 
  | \alt-before-after-c2: 'AFTER' 
  ;

syntax Evaluate_phrase_2 =
  \evaluate-phrase-2: 'NOT'? Arithmetic_expression Through_arithmetic_expression 
  ;

syntax Alt_all_leading =
  \alt-all-leading-c1: 'ALL' 
  | \alt-all-leading-c2: 'LEADING' 
  ;

syntax Start_statement =
  \start-statement: 'START' File_name Key_is_rel_op_qualified_data_name? Invalid_key_statement_list? Not_invalid_key_statement_list? 'END-START'? 
  ;

syntax Set_statement =
  \set-statement: 'SET' Set_statement_phrase+ 
  ;

syntax Using_data_name_pluslist =
  \using-data-name-pluslist: 'USING' Data_name+ 
  ;

syntax Not_at_end_statement_list =
  \not-at-end-statement-list: 'NOT' 'AT'? 'END' Statement_list 
  ;

syntax Alt_file_names_i_o =
  \alt-file-names-i-o-c1: File_names 
  | \alt-file-names-i-o-c3: 'OUTPUT' 
  | \alt-file-names-i-o-c2: 'INPUT' 
  | \alt-file-names-i-o-c4: 'I-O' 
  | \alt-file-names-i-o-c5: 'EXTEND' 
  ;

syntax Reference_parameter =
  \reference-parameter: By_reference? Identifier 
  ;

syntax Output_procedure =
  \output-procedure: 'OUTPUT' 'PROCEDURE' 'IS'? Procedure_name Through_procedure_name? 
  ;

syntax Evaluate_condition =
  \evaluate-condition-c3: 'FALSE' 
  | \evaluate-condition-c1: Condition 
  | \evaluate-condition-c2: 'TRUE' 
  ;

syntax Go_to_statement_2 =
  \go-to-statement-2: 'GO' 'TO'? Procedure_name+ 'DEPENDING' 'ON'? Identifier 
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

syntax Nr_lines_phrase =
  \nr-lines-phrase: Cobword_int Lines? 
  ;

syntax Open_statement_i_o =
  \open-statement-i-o: 'I-O' File_name+ 
  ;

syntax Move_statement_2 =
  \move-statement-2: 'MOVE' Corresponding Identifier 'TO' Identifier+ 
  ;

syntax Search_statement_condition =
  \search-statement-condition-c1: Search_statement_equal_expression 
  | \search-statement-condition-c2: Condition_name_reference 
  ;

syntax Multiply_statement =
  \multiply-statement-c1: Multiply_statement_2 
  | \multiply-statement-c2: Multiply_statement_1 
  ;

syntax Go_to_statement_1 =
  \go-to-statement-1: 'GO' 'TO'? Procedure_name 
  ;

syntax Alt_statement_list_next_sentence =
  \alt-statement-list-next-sentence-c1: Statement_list 
  | \alt-statement-list-next-sentence-c2: Next_sentence 
  ;

syntax Open_statement_input_file_name =
  \open-statement-input-file-name: File_name Alt_reversed_with_no_rewind? 
  ;

syntax Release_statement =
  \release-statement: 'RELEASE' Record_name From_identifier? 
  ;

syntax Continue_statement =
  \continue-statement: 'CONTINUE' 
  ;

syntax Close_statement_file_name =
  \close-statement-file-name: File_name Close_statement_options? 
  ;

syntax Inspect_statement_2 =
  \inspect-statement-2: 'INSPECT' Identifier 'CONVERTING' Id_or_lit 'TO' Id_or_lit Before_after_phrase* 
  ;

syntax Perform_statement_1_procedure =
  \perform-statement-1-procedure: Procedure_name Through_procedure_name? 
  ;

syntax Not_on_overflow_statement_list =
  \not-on-overflow-statement-list: 'NOT' 'ON'? 'OVERFLOW' Statement_list 
  ;

syntax Subtract_statement_2 =
  \subtract-statement-2: 'SUBTRACT' Id_or_lit+ 'FROM' Id_or_lit 'GIVING' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? 'END-SUBTRACT'? 
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
  \use-statement-c1: Use_statement_1 
  | \use-statement-c2: Use_statement_2 
  | \use-statement-c3: Use_statement_3 
  ;

syntax Giving_file_names =
  \giving-file-names: 'GIVING' File_name+ 
  ;

syntax Inspect_statement_1 =
  \inspect-statement-1: 'INSPECT' Identifier 'TALLYING' Tallying_argument+ 
  ;

syntax For_removal =
  \for-removal: 'FOR'? 'REMOVAL' 
  ;

syntax Sort_statement_in =
  \sort-statement-in-c1: Using_file_names 
  | \sort-statement-in-c2: Input_procedure 
  ;

syntax Invalid_key_statement_list =
  \invalid-key-statement-list: 'INVALID' 'KEY'? Statement_list 
  ;

syntax Go_to_statement_3 =
  \go-to-statement-3: 'GO' 'TO'? 'MORE-LABELS' 
  ;

syntax When_condition_stats =
  \when-condition-stats: 'WHEN' Condition Alt_statement_list_next_sentence 
  ;

syntax Subtract_statement_1 =
  \subtract-statement-1: 'SUBTRACT' Id_or_lit+ 'FROM' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? 'END-SUBTRACT'? 
  ;

syntax Inspect_replacing_argument =
  \inspect-replacing-argument: Inspect_by_argument 'BY' Inspect_by_argument Before_after_phrase* 
  ;

syntax Initialize_replacing_phrase =
  \initialize-replacing-phrase: 'REPLACING' Initialize_replacing_argument+ 
  ;

syntax Parameter =
  \parameter-c2: Content_parameter 
  | \parameter-c1: Reference_parameter 
  ;

syntax Page_phrase =
  \page-phrase-c2: 'PAGE' 
  | \page-phrase-c1: Nr_lines_phrase 
  ;

syntax Use_statement_1 =
  \use-statement-1: 'USE' 'GLOBAL'? 'AFTER' 'STANDARD'? Alt_exception_error 'PROCEDURE' 'ON'? Alt_file_names_i_o 
  ;

syntax Evaluate_statement =
  \evaluate-statement: 'EVALUATE' Evaluate_condition Also_phrase* When_phrases+ When_other_phrase? 'END-EVALUATE'? 
  ;

syntax Divide_statement =
  \divide-statement-c3: Divide_statement_2 
  | \divide-statement-c5: Divide_statement_1 
  | \divide-statement-c2: Divide_statement_5 
  | \divide-statement-c1: Divide_statement_4 
  | \divide-statement-c4: Divide_statement_3 
  ;

syntax Perform_statement_2_statement_list =
  \perform-statement-2-statement-list: Perform_varying_phrase Statement_list 'END-PERFORM' 
  ;

syntax Perform_statement_3_statement_list =
  \perform-statement-3-statement-list: Cobword_int 'TIMES' Statement_list 'END-PERFORM' 
  ;

syntax Merge_statement =
  \merge-statement: 'MERGE' File_name On_key_phrase+ Collating_sequence? 'USING' File_name File_name+ Merge_statement_tail 
  ;

syntax Key_is_qualified_data_name =
  \key-is-qualified-data-name: 'KEY' 'IS'? Qualified_data_name 
  ;

syntax Close_statement =
  \close-statement: 'CLOSE' Close_statement_file_name+ 
  ;

syntax Into_identifier =
  \into-identifier: 'INTO' Identifier 
  ;

syntax Delimiter_in_identifier =
  \delimiter-in-identifier: 'DELIMITER' 'IN'? Identifier 
  ;

syntax Use_statement_3 =
  \use-statement-3: 'USE' 'FOR'? 'DEBUGGING' 'ON'? Alt_procedures_all_procedures 
  ;

syntax Search_statement_2 =
  \search-statement-2: 'SEARCH' 'ALL' Identifier At_end_statement_list? 'WHEN' Search_statement_condition Search_statement_condition_tail* Alt_statement_list_next_sentence 'END-SEARCH'? 
  ;

syntax On_overflow_statement_list =
  \on-overflow-statement-list: 'ON'? 'OVERFLOW' Statement_list 
  ;

syntax With_test =
  \with-test: 'WITH'? 'TEST' Alt_before_after 
  ;

syntax Set_oper =
  \set-oper-c2: Alt_up_down_by 
  | \set-oper-c1: 'TO' 
  ;

syntax Accept_statement_2 =
  \accept-statement-2: 'ACCEPT' Identifier 'FROM' Date 
  ;

syntax Key_is =
  \key-is: 'KEY' 'IS'? 
  ;

syntax Perform_statement_1_statement_list =
  \perform-statement-1-statement-list: Statement_list 'END-PERFORM' 
  ;

syntax Search_statement_equal_expression =
  \search-statement-equal-expression: Identifier 'IS'? Equal_to Arithmetic_expression 
  ;

syntax Cancel_statement =
  \cancel-statement: 'CANCEL' Id_or_lit+ 
  ;

syntax Use_statement_2 =
  \use-statement-2: 'USE' 'GLOBAL'? 'AFTER' 'STANDARD'? Alt_beginning_ending? Alt_file_reel_unit? 'LABEL' 'PROCEDURE' 'ON'? Alt_file_names_i_o 
  ;

syntax Search_statement_1 =
  \search-statement-1: 'SEARCH' Identifier Varying_identifier? At_end_statement_list? When_condition_stats+ 'END-SEARCH'? 
  ;

syntax Accept_statement_1 =
  \accept-statement-1: 'ACCEPT' Identifier From_environment_name? 
  ;

syntax When_other_phrase =
  \when-other-phrase: 'WHEN' 'OTHER' Statement_list 
  ;

syntax If_statement =
  \if-statement: 'IF' Condition 'THEN'? Alt_statement_list_next_sentence Else_phrase? 'END-IF'? 
  ;

syntax Proceed_to =
  \proceed-to: 'PROCEED' 'TO' 
  ;

syntax From_environment_name =
  \from-environment-name: 'FROM' Cobword \ CobwordKeywords 
  ;

syntax Next_sentence =
  \next-sentence: 'NEXT' 'SENTENCE' 
  ;

syntax Statement =
  \statement-c18: Exit_program_statement 
  | \statement-c23: Merge_statement 
  | \statement-c30: Search_statement 
  | \statement-c11: Compute_statement 
  | \statement-c19: Exit_statement 
  | \statement-c7: Alter_statement 
  | \statement-c8: Call_statement 
  | \statement-c31: Set_statement 
  | \statement-c34: Stop_statement 
  | \statement-c15: Divide_statement 
  | \statement-c14: Display_statement 
  | \statement-c26: Read_statement 
  | \statement-c35: String_statement 
  | \statement-c36: Subtract_statement 
  | \statement-c1: Move_statement 
  | \statement-c4: Go_to_statement 
  | \statement-c20: Goback_statement 
  | \statement-c6: Add_statement 
  | \statement-c5: Accept_statement 
  | \statement-c13: Delete_statement 
  | \statement-c21: Initialize_statement 
  | \statement-c12: Continue_statement 
  | \statement-c27: Release_statement 
  | \statement-c37: Unstring_statement 
  | \statement-c10: Close_statement 
  | \statement-c2: If_statement 
  | \statement-c22: Inspect_statement 
  | \statement-c32: Sort_statement 
  | \statement-c38: Write_statement 
  | \statement-c17: Evaluate_statement 
  | \statement-c33: Start_statement 
  | \statement-c28: Return_statement 
  | \statement-c3: Perform_statement 
  | \statement-c16: Entry_statement 
  | \statement-c9: Cancel_statement 
  | \statement-c25: Open_statement 
  | \statement-c24: Multiply_statement 
  | \statement-c29: Rewrite_statement 
  ;

syntax Not_on_size_error_statement_list =
  \not-on-size-error-statement-list: 'NOT' 'ON'? 'SIZE' 'ERROR' Statement_list 
  ;

syntax Write_statement =
  \write-statement: 'WRITE' Record_name From_identifier? Advancing_phrase? Write_exceptions 'END-WRITE'? 
  ;

syntax Tallying_for_argument_2 =
  \tallying-for-argument-2: Alt_all_leading Tallying_for_id_or_lit+ 
  ;

syntax On_key_is_phrase =
  \on-key-is-phrase: 'ON'? Alt_ascending_descending Key_is? Qualified_data_name+ 
  ;

syntax Date =
  \date-c4: 'TIME' 
  | \date-c2: 'DAY' 
  | \date-c1: 'DATE' 
  | \date-c3: 'DAY-OF-WEEK' 
  ;

syntax Exit_statement =
  \exit-statement: 'EXIT' 
  ;

syntax Cobword_rounded =
  \cobword-rounded: Identifier 'ROUNDED'? 
  ;

syntax Statement_list =
  \statement-list: Statement+ 
  ;

syntax Sort_statement =
  \sort-statement: 'SORT' File_name On_key_is_phrase+ With_duplicates_in_order? Collating_sequence? Sort_statement_in Sort_statement_out 
  ;

syntax Call_statement =
  \call-statement: 'CALL' Id_or_lit Using_parameters? Call_rest_phrase 'END-CALL'? 
  ;

syntax Tallying_for_argument_1 =
  \tallying-for-argument-1: 'CHARACTERS' Before_after_phrase* 
  ;

syntax String_statement =
  \string-statement: 'STRING' Delimited_by_phrase+ 'INTO' Identifier With_pointer_identifier? On_overflow_statement_list? Not_on_overflow_statement_list? 'END-STRING'? 
  ;

syntax Move_statement =
  \move-statement-c2: Move_statement_2 
  | \move-statement-c1: Move_statement_1 
  ;

syntax Id_or_lit_size =
  \id-or-lit-size-c1: Literal 
  | \id-or-lit-size-c3: 'SIZE' 
  | \id-or-lit-size-c2: Identifier 
  ;

syntax Initialize_statement =
  \initialize-statement: 'INITIALIZE' Identifier+ Initialize_replacing_phrase? 
  ;

syntax Unstring_statement_dst =
  \unstring-statement-dst: Identifier Delimiter_in_identifier? Count_in_identifier? 
  ;

syntax Return_statement =
  \return-statement: 'RETURN' File_name 'RECORD'? Into_identifier? 'AT'? 'END' Statement_list Not_at_end_statement_list? 'END-RETURN'? 
  ;

syntax Using_file_names =
  \using-file-names: 'USING' File_name+ 
  ;

syntax With_no_rewind =
  \with-no-rewind: 'WITH'? 'NO' 'REWIND' 
  ;

syntax Tallying_for_id_or_lit =
  \tallying-for-id-or-lit: Id_or_lit Before_after_phrase* 
  ;

syntax Content_parameter =
  \content-parameter: 'BY'? 'CONTENT' Content_parameter_value+ 
  ;

syntax Perform_statement_4_alts =
  \perform-statement-4-alts-c2: Perform_statement_4_statement_list 
  | \perform-statement-4-alts-c1: Perform_statement_4_procedure 
  ;

syntax On_size_error_statement_list =
  \on-size-error-statement-list: 'ON'? 'SIZE' 'ERROR' Statement_list 
  ;

syntax Add_statement_1 =
  \add-statement-1: 'ADD' Id_or_lit+ 'TO' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? 'END-ADD'? 
  ;

syntax Perform_statement_1 =
  \perform-statement-1: 'PERFORM' Perform_statement_1_alts 
  ;

syntax Call_rest_phrase =
  \call-rest-phrase: On_exception_statement_list? Not_on_exception_statement_list? On_overflow_statement_list? 
  ;

syntax By_reference =
  \by-reference: 'BY'? 'REFERENCE' 
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
  \go-to-statement-c3: Go_to_statement_3 
  | \go-to-statement-c2: Go_to_statement_1 
  | \go-to-statement-c1: Go_to_statement_2 
  ;

syntax Entry_statement =
  \entry-statement: 'ENTRY' Literal Using_data_name_pluslist? 
  ;

syntax Or_all_id_or_lit =
  \or-all-id-or-lit: 'OR' 'ALL'? Id_or_lit 
  ;

syntax Inspect_replacing_phrase_2 =
  \inspect-replacing-phrase-2: Alt_all_leading_first Inspect_replacing_argument+ 
  ;

syntax File_names =
  \file-names: File_name+ 
  ;

syntax Add_statement_3 =
  \add-statement-3: 'ADD' Corresponding Identifier 'TO' Identifier 'ROUNDED'? On_size_error_statement_list? Not_on_size_error_statement_list? 'END-ADD'? 
  ;

syntax Perform_statement_3 =
  \perform-statement-3: 'PERFORM' Perform_statement_3_alts 
  ;

syntax Alt_run_literal =
  \alt-run-literal-c1: 'RUN' 
  | \alt-run-literal-c2: Literal 
  ;

syntax Open_statement_input =
  \open-statement-input: 'INPUT' Open_statement_input_file_name+ 
  ;

syntax Perform_statement_2_alts =
  \perform-statement-2-alts-c1: Perform_statement_2_procedure 
  | \perform-statement-2-alts-c2: Perform_statement_2_statement_list 
  ;

syntax Using_parameters =
  \using-parameters: 'USING' Parameter+ 
  ;

syntax With_pointer_identifier =
  \with-pointer-identifier: 'WITH'? 'POINTER' Identifier 
  ;

syntax Inspect_replacing_phrase_1 =
  \inspect-replacing-phrase-1: 'CHARACTERS' 'BY' Id_or_lit Before_after_phrase* 
  ;

syntax Subtract_statement =
  \subtract-statement-c2: Subtract_statement_1 
  | \subtract-statement-c1: Subtract_statement_2 
  | \subtract-statement-c3: Subtract_statement_3 
  ;

syntax Add_statement_2 =
  \add-statement-2: 'ADD' Id_or_lit+ To_id_or_lit? 'GIVING' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? 'END-ADD'? 
  ;

syntax Perform_statement_2 =
  \perform-statement-2: 'PERFORM' Perform_statement_2_alts 
  ;

syntax Inspect_statement =
  \inspect-statement-c1: Inspect_statement_3 
  | \inspect-statement-c4: Inspect_statement_4 
  | \inspect-statement-c3: Inspect_statement_2 
  | \inspect-statement-c2: Inspect_statement_1 
  ;

syntax Write_exceptions =
  \write-exceptions: At_end_of_page_statement_list? Not_at_end_of_page_statement_list? Invalid_key_statement_list? Not_invalid_key_statement_list? 
  ;

syntax Perform_statement_3_alts =
  \perform-statement-3-alts-c1: Perform_statement_3_procedure 
  | \perform-statement-3-alts-c2: Perform_statement_3_statement_list 
  ;

syntax Rel_op =
  \rel-op-c1: Equal_to 
  | \rel-op-c2: Greater_than_or_equal_to 
  | \rel-op-c3: Greater_than 
  ;

syntax Compute_statement =
  \compute-statement: 'COMPUTE' Cobword_rounded+ Equal Arithmetic_expression On_size_error_statement_list? Not_on_size_error_statement_list? 'END-COMPUTE'? 
  ;

syntax Multiply_statement_2 =
  \multiply-statement-2: 'MULTIPLY' Id_or_lit 'BY' Id_or_lit 'GIVING' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? 'END-MULTIPLY'? 
  ;

syntax Alt_no_rewind_lock =
  \alt-no-rewind-lock-c1: No_rewind 
  | \alt-no-rewind-lock-c2: 'LOCK' 
  ;

syntax Perform_statement_4_statement_list =
  \perform-statement-4-statement-list: Perform_until_phrase Statement_list 'END-PERFORM' 
  ;

syntax Close_statement_options =
  \close-statement-options-c2: Close_statement_options_2 
  | \close-statement-options-c1: Close_statement_options_1 
  ;

syntax Set_src =
  \set-src-c5: 'OFF' 
  | \set-src-c1: Identifier 
  | \set-src-c2: Literal 
  | \set-src-c4: 'ON' 
  | \set-src-c3: 'TRUE' 
  ;

syntax Alt_procedures_all_procedures =
  \alt-procedures-all-procedures-c2: All_procedures 
  | \alt-procedures-all-procedures-c1: Procedure_names 
  ;

syntax Alt_reversed_with_no_rewind =
  \alt-reversed-with-no-rewind-c1: 'REVERSED' 
  | \alt-reversed-with-no-rewind-c2: With_no_rewind 
  ;

syntax Merge_statement_tail =
  \merge-statement-tail-c1: Output_procedure 
  | \merge-statement-tail-c2: Giving_file_names 
  ;

syntax Open_statement_output =
  \open-statement-output: 'OUTPUT' Open_statement_output_file_name+ 
  ;

syntax At_end_of_page_statement_list =
  \at-end-of-page-statement-list: 'AT'? End_of_page Statement_list 
  ;

syntax Perform_statement_4 =
  \perform-statement-4: 'PERFORM' Perform_statement_4_alts 
  ;

syntax Perform_statement_1_alts =
  \perform-statement-1-alts-c1: Perform_statement_1_procedure 
  | \perform-statement-1-alts-c2: Perform_statement_1_statement_list 
  ;

syntax Set_statement_phrase =
  \set-statement-phrase: Identifier+ Set_oper Set_src 
  ;

syntax Tallying_argument =
  \tallying-argument: Identifier 'FOR' Tallying_for_argument+ 
  ;

syntax Alter_statement =
  \alter-statement: 'ALTER' Procedure_to_procedure+ 
  ;

syntax Multiply_statement_1 =
  \multiply-statement-1: 'MULTIPLY' Id_or_lit 'BY' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? 'END-MULTIPLY'? 
  ;

syntax Alt_up_down_by =
  \alt-up-down-by: Alt_up_down 'BY' 
  ;

syntax Perform_varying_phrase =
  \perform-varying-phrase: With_test? 'VARYING' Identifier 'FROM' Id_or_lit 'BY' Id_or_lit 'UNTIL' Condition 
  ;

syntax Read_statement =
  \read-statement: 'READ' File_name 'NEXT'? 'RECORD'? Into_identifier? Key_is_qualified_data_name? Invalid_key_statement_list? Not_invalid_key_statement_list? At_end_statement_list? Not_at_end_statement_list? 'END-READ'? 
  ;
