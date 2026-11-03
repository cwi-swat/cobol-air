module lang::cobol85::\syntax::Statement

extend lang::cobol85::\syntax::Condition;
extend lang::cobol85::\syntax::Lexical;
extend lang::cobol85::\syntax::Expression;

// the reserved words of this module
keyword CobwordKeywords
  = 'ACCEPT'
  | 'ADD'
  | 'ADVANCING'
  | 'AFTER'
  | 'ALL'
  | 'ALPHABETIC'
  | 'ALPHANUMERIC'
  | 'ALPHANUMERIC-EDITED'
  | 'ALSO'
  | 'ALTER'
  | 'AND'
  | 'ANY'
  | 'AT'
  | 'BEFORE'
  | 'BEGINNING'
  | 'BY'
  | 'CALL'
  | 'CANCEL'
  | 'CHARACTERS'
  | 'CLOSE'
  | 'COLLATING'
  | 'COMPUTE'
  | 'CONTENT'
  | 'CONTINUE'
  | 'CONVERTING'
  | 'COPY'
  | 'CORR'
  | 'CORRESPONDING'
  | 'COUNT'
  | 'DATA'
  | 'DATE'
  | 'DAY'
  | 'DAY-OF-WEEK'
  | 'DBCS'
  | 'DEBUGGING'
  | 'DELETE'
  | 'DELIMITED'
  | 'DELIMITER'
  | 'DEPENDING'
  | 'DISABLE'
  | 'DISPLAY'
  | 'DIVIDE'
  | 'DOWN'
  | 'DUPLICATES'
  | 'EGCS'
  | 'EGI'
  | 'ELSE'
  | 'EMI'
  | 'ENABLE'
  | 'END'
  | 'END-ADD'
  | 'END-CALL'
  | 'END-COMPUTE'
  | 'END-DELETE'
  | 'END-DIVIDE'
  | 'END-EVALUATE'
  | 'END-IF'
  | 'END-MULTIPLY'
  | 'END-OF-PAGE'
  | 'END-PERFORM'
  | 'END-READ'
  | 'END-RETURN'
  | 'END-REWRITE'
  | 'END-SEARCH'
  | 'END-START'
  | 'END-STRING'
  | 'END-SUBTRACT'
  | 'END-UNSTRING'
  | 'END-WRITE'
  | 'ENDING'
  | 'ENTRY'
  | 'EOP'
  | 'EQUAL'
  | 'ERROR'
  | 'ESI'
  | 'EVALUATE'
  | 'EXCEPTION'
  | 'EXIT'
  | 'EXTEND'
  | 'FALSE'
  | 'FILE'
  | 'FIRST'
  | 'FOR'
  | 'FROM'
  | 'GIVING'
  | 'GLOBAL'
  | 'GO'
  | 'GOBACK'
  | 'I-O'
  | 'IF'
  | 'IN'
  | 'INITIAL'
  | 'INITIALIZE'
  | 'INPUT'
  | 'INSPECT'
  | 'INTO'
  | 'INVALID'
  | 'IS'
  | 'KEY'
  | 'LABEL'
  | 'LEADING'
  | 'LINE'
  | 'LINES'
  | 'LOCK'
  | 'MERGE'
  | 'MESSAGE'
  | 'MORE-LABELS'
  | 'MOVE'
  | 'MULTIPLY'
  | 'NEXT'
  | 'NO'
  | 'NOT'
  | 'NUMERIC'
  | 'NUMERIC-EDITED'
  | 'OF'
  | 'OFF'
  | 'ON'
  | 'OPEN'
  | 'OR'
  | 'ORDER'
  | 'OTHER'
  | 'OUTPUT'
  | 'OVERFLOW'
  | 'PAGE'
  | 'PERFORM'
  | 'POINTER'
  | 'PROCEDURE'
  | 'PROCEDURES'
  | 'PROCEED'
  | 'PROGRAM'
  | 'PURGE'
  | 'READ'
  | 'RECEIVE'
  | 'RECORD'
  | 'REEL'
  | 'REFERENCE'
  | 'RELEASE'
  | 'REMAINDER'
  | 'REMOVAL'
  | 'REPLACING'
  | 'RETURN'
  | 'REVERSED'
  | 'REWIND'
  | 'REWRITE'
  | 'ROUNDED'
  | 'RUN'
  | 'SEARCH'
  | 'SEND'
  | 'SENTENCE'
  | 'SEQUENCE'
  | 'SET'
  | 'SIZE'
  | 'SORT'
  | 'STANDARD'
  | 'START'
  | 'STOP'
  | 'STRING'
  | 'SUBTRACT'
  | 'TALLYING'
  | 'TEST'
  | 'THEN'
  | 'TIME'
  | 'TIMES'
  | 'TO'
  | 'TRUE'
  | 'UNIT'
  | 'UNSTRING'
  | 'UNTIL'
  | 'UP'
  | 'UPON'
  | 'USE'
  | 'USING'
  | 'VARYING'
  | 'WHEN'
  | 'WITH'
  | 'WRITE'
  ;
syntax On_key_phrase = ascendingDescending: 'ON'? Alt_ascending_descending 'KEY'? Qualified_data_name+;
syntax Accept_statement
  = acceptFrom: 'ACCEPT' Identifier 'FROM' Date
  | accept: 'ACCEPT' Identifier
  | accept: 'ACCEPT' Identifier 'FROM' Cobword \ CobwordKeywords
  ;

syntax EndSearch
  = 'END-SEARCH'
  | () >> "."
  ;

syntax Search_statement
  = searchAll: 'SEARCH' 'ALL' Identifier At_end_statement_list? 'WHEN' Search_statement_condition Search_statement_condition_tail* Alt_statement_list_next_sentence EndSearch
  | search: 'SEARCH' Identifier At_end_statement_list? When_condition_stats+ EndSearch
  | search: 'SEARCH' Identifier 'VARYING' Identifier At_end_statement_list? When_condition_stats+ EndSearch
  ;
syntax Perform_until_phrase = until: With_test? 'UNTIL' Expression;
syntax Search_statement_condition_tail = and: 'AND' Search_statement_condition;

syntax Procedure_to_procedure
  = to: Procedure_name 'TO' Procedure_name
  | to: Procedure_name 'TO' 'PROCEED' 'TO' Procedure_name
  ;

syntax Delimited_by_phrase = delimited: Id_or_lit+ 'DELIMITED' 'BY'? Id_or_lit_size;
syntax Inspect_by_argument
  = figurativeConstantSimple: Figurative_constant_simple
  | nonnumeric: Nonnumeric
  | identifier: Identifier
  ;
syntax Perform_after_phrase = after: 'AFTER' Identifier 'FROM' Id_or_lit 'BY' Id_or_lit 'UNTIL' Expression;
syntax Initialize_replacing_argument = by: Initialize_replacing_type 'DATA'? 'BY' Id_or_lit;
syntax Sort_statement_out
  = givingFileNames: Giving_file_names
  | outputProcedure: Output_procedure
  ;
syntax Collating_sequence = sequence: 'COLLATING'? 'SEQUENCE' 'IS'? Alphabet_name;

syntax Before_after_phrase = beforeAfter: Alt_before_after 'INITIAL'? Id_or_lit;

syntax Tallying_for_argument
  = characters: 'CHARACTERS' Before_after_phrase*
  | allLeading: Alt_all_leading Tallying_for_id_or_lit+
  ;
syntax Alt_file_reel_unit
  = unit: 'UNIT'
  | reel: 'REEL'
  | file: 'FILE'
  ;
syntax Lines
  = lines: 'LINES'
  | line: 'LINE'
  ;
syntax Id_or_lit
  = literal: Literal
  | identifier: Identifier
  ;
syntax Evaluate_phrase
  = through: 'NOT'? Expression!negation Through Expression
  | \true: 'TRUE'
  | condition: Expression // also covers [NOT] value; the EVALUATE subject decides which it is
  | \false: 'FALSE'
  | \any: 'ANY'
  ;
syntax Alt_beginning_ending
  = beginning: 'BEGINNING'
  | ending: 'ENDING'
  ;

syntax When_phrase = \when: 'WHEN' Evaluate_phrase When_phrase_also_phrase*;
syntax From_identifier = from: 'FROM' Identifier;

syntax Open_statement_phrase
  = io: 'I-O' File_name+
  | input: 'INPUT' Open_statement_input_file_name+
  | output: 'OUTPUT' Open_statement_output_file_name+
  | \extend: 'EXTEND' File_name+
  ;

syntax At_end_statement_list = end: 'AT'? 'END' Statement_list;

syntax EndAdd = 'END-ADD'?;

//  | () >> ".";
syntax Add_statement
  = addGiving: 'ADD' Id_or_lit+ 'GIVING' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndAdd
  | addGiving: 'ADD' Id_or_lit+ 'TO' Id_or_lit 'GIVING' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndAdd
  | addCorresponding: 'ADD' Corresponding Identifier 'TO' Identifier 'ROUNDED'? On_size_error_statement_list? Not_on_size_error_statement_list? EndAdd
  | addTo: 'ADD' Id_or_lit+ 'TO' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndAdd
  ;

syntax Also_phrase = also: 'ALSO' Evaluate_condition;

syntax Through_procedure_name = through: Through Procedure_name;

syntax Perform_statement
  = performVarying: 'PERFORM' Perform_statement_2_alts
  | performTimes: 'PERFORM' Perform_statement_3_alts
  | perform: 'PERFORM' Perform_statement_1_alts
  | performUntil: 'PERFORM' Perform_statement_4_alts
  ;
syntax Alt_removal_no_rewind
  = withNoRewind: With_no_rewind
  | removal: 'FOR'? 'REMOVAL'
  ;

syntax Alt_up_down
  = down: 'DOWN'
  | up: 'UP'
  ;

syntax When_phrase_also_phrase = also: 'ALSO' Evaluate_phrase;

syntax Cobword_int
  = identifier: Identifier
  | integer: Integer
  ;
syntax Corresponding
  = corr: 'CORR'
  | corresponding: 'CORRESPONDING'
  ;

syntax End_of_page
  = endOfPage: 'END-OF-PAGE'
  | eop: 'EOP'
  ;
syntax Inspect_replacing_phrase
  = characters: 'CHARACTERS' 'BY' Id_or_lit Before_after_phrase*
  | allLeadingFirst: Alt_all_leading_first Inspect_replacing_argument+
  ;
syntax Alt_before_after
  = before: 'BEFORE'
  | after: 'AFTER'
  ;
syntax Alt_all_leading
  = \all: 'ALL'
  | leading: 'LEADING'
  ;
syntax Using_data_name_pluslist = using: 'USING' Data_name+;

syntax Not_at_end_statement_list = not: 'NOT' 'AT'? 'END' Statement_list;

syntax Alt_file_names_i_o
  = fileName: File_name+
  | output: 'OUTPUT'
  | input: 'INPUT'
  | io: 'I-O'
  | \extend: 'EXTEND'
  ;
syntax Output_procedure = output: 'OUTPUT' 'PROCEDURE' 'IS'? Procedure_name Through_procedure_name?;

syntax Evaluate_condition
  = \false: 'FALSE'
  | condition: Expression
  | \true: 'TRUE'
  ;
syntax When_phrases = whenPhrase: When_phrase+ Statement_list;

syntax Open_statement_output_file_name = fileName: File_name With_no_rewind?;

syntax Content_parameter_value
  = identifier: Identifier
  | literal: Literal
  ;

syntax Equal
  = equalSign: "="
  | equal: 'EQUAL'
  ;
syntax Search_statement_condition
  = equal: Identifier 'IS'? Equal_to Expression!conjunction // AND starts the next key condition
  | conditionName: Alphabetic_user_defined_word In_data_or_file_or_mnemonic_name* Subscript_parentheses*
  ;

syntax EndMultiply = 'END-MULTIPLY'?;

// | () >> ".";
syntax Multiply_statement
  = multiplyByGiving: 'MULTIPLY' Id_or_lit 'BY' Id_or_lit 'GIVING' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndMultiply
  | multiplyBy: 'MULTIPLY' Id_or_lit 'BY' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndMultiply
  ;
syntax Alt_statement_list_next_sentence
  = statementList: Statement_list
  | nextSentence: 'NEXT' 'SENTENCE'
  ;

syntax Open_statement_input_file_name = fileName: File_name Alt_reversed_with_no_rewind?;
syntax Close_statement_file_name = fileName: File_name Close_statement_options?;
syntax Not_on_overflow_statement_list = not: 'NOT' 'ON'? 'OVERFLOW' Statement_list;
syntax Initialize_replacing_type
  = alphabetic: 'ALPHABETIC'
  | numericEdited: 'NUMERIC-EDITED'
  | numeric: 'NUMERIC'
  | alphanumericEdited: 'ALPHANUMERIC-EDITED'
  | alphanumeric: 'ALPHANUMERIC'
  | dbcs: 'DBCS'
  | egcs: 'EGCS'
  ;

syntax Use_statement
  = useAfterProcedure: 'USE' 'GLOBAL'? 'AFTER' 'STANDARD'? Alt_exception_error 'PROCEDURE' 'ON'? Alt_file_names_i_o
  | useAfterLabel: 'USE' 'GLOBAL'? 'AFTER' 'STANDARD'? Alt_beginning_ending? Alt_file_reel_unit? 'LABEL' 'PROCEDURE' 'ON'? Alt_file_names_i_o
  | useDebugging: 'USE' 'FOR'? 'DEBUGGING' 'ON'? Alt_procedures_all_procedures
  ;

syntax Giving_file_names = giving: 'GIVING' File_name+;
syntax Sort_statement_in
  = using: 'USING' File_name+
  | input: 'INPUT' 'PROCEDURE' 'IS'? Procedure_name Through_procedure_name?
  ;

syntax Invalid_key_statement_list = invalid: 'INVALID' 'KEY'? Statement_list;
syntax When_condition_stats = \when: 'WHEN' Expression Alt_statement_list_next_sentence;
syntax Inspect_replacing_argument = by: Inspect_by_argument 'BY' Inspect_by_argument Before_after_phrase*;
// a BY CONTENT or BY REFERENCE phrase applies to all the parameters that follow it, up to the next BY phrase;
// parameters before the first BY phrase are passed by reference
syntax Using_parameters
  = identifier: Identifier+ Parameter_group*
  | identifier: Parameter_group+
  ;

syntax Parameter_group
  = content: 'BY'? 'CONTENT' Content_parameter_value+
  | reference: 'BY'? 'REFERENCE' Identifier+
  ;

syntax Page_phrase
  = page: 'PAGE'
  | cobwordInt: Cobword_int Lines?
  | zeroes: Zeroes Lines?
  ;

syntax EndDivide = 'END-DIVIDE'?;

// | () >> ".";
syntax Divide_statement
  = divideIntoGiving: 'DIVIDE' Id_or_lit 'INTO' Id_or_lit 'GIVING' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndDivide
  | divideInto: 'DIVIDE' Id_or_lit 'INTO' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndDivide
  | divideByGivingRemainder: 'DIVIDE' Id_or_lit 'BY' Id_or_lit 'GIVING' Identifier 'ROUNDED'? 'REMAINDER' Identifier On_size_error_statement_list? Not_on_size_error_statement_list? EndDivide
  | divideIntoGivingRemainder: 'DIVIDE' Id_or_lit 'INTO' Id_or_lit 'GIVING' Identifier 'ROUNDED'? 'REMAINDER' Identifier On_size_error_statement_list? Not_on_size_error_statement_list? EndDivide
  | divideByGiving: 'DIVIDE' Id_or_lit 'BY' Id_or_lit 'GIVING' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndDivide
  ;
syntax Into_identifier = into: 'INTO' Identifier;
syntax On_overflow_statement_list = overflow: 'ON'? 'OVERFLOW' Statement_list;

syntax With_test = \test: 'WITH'? 'TEST' Alt_before_after;

syntax Set_oper
  = by: Alt_up_down 'BY'
  | to: 'TO'
  ;
syntax If_statement
  = \if: 'IF' Expression 'THEN'? Alt_statement_list_next_sentence () !>> 'ELSE' EndIf
  | ifElse: 'IF' Expression 'THEN'? Alt_statement_list_next_sentence 'ELSE' Alt_statement_list_next_sentence EndIf
  ;

// an IF without END-IF ends at the period, or at the ELSE or WHEN of an enclosing IF or EVALUATE
syntax EndIf
  = 'END-IF'
  | () >> "."
  | () >> 'ELSE'
  | () >> 'WHEN'
  ;
syntax EndCompute = 'END-COMPUTE'?;
// | () >> ".";
syntax EndCall = 'END-CALL'?;
// | () >> ".";
syntax EndString = 'END-STRING'?;
// | () >> ".";
syntax EndDelete = 'END-DELETE'?;
syntax EndUnString = 'END-UNSTRING'?;
// | () >> ".";
syntax EndWrite = 'END-WRITE'?;
// | () >> ".";
syntax EndEvaluate = 'END-EVALUATE'?;
// | () >> ".";
syntax EndReturn
  = 'END-RETURN'
  | () >> "."
  ;
syntax EndStart = 'END-START'?;
syntax EndRewrite = 'END-REWRITE'?;
syntax EndRead = 'END-READ'?;

syntax Statement
  = exitProgram: 'EXIT' 'PROGRAM'
  | receive: 'RECEIVE' File_name 'MESSAGE'? 'INTO' Identifier No_data_statement?
  | receive: 'RECEIVE' File_name 'SEGMENT' 'INTO' Identifier No_data_statement?
  | enable: 'ENABLE' Communication_io_mode File_name Communication_key_phrase?
  | disable: 'DISABLE' Communication_io_mode File_name Communication_key_phrase?
  | send: 'SEND' File_name From_identifier? Send_with_phrase? Send_advancing_phrase? Send_replacing_line?
  | purge: 'PURGE' File_name
  | merge: 'MERGE' File_name On_key_phrase+ Collating_sequence? 'USING' File_name File_name+ Merge_statement_tail
  | search: Search_statement
  | compute: 'COMPUTE' Cobword_rounded+ Equal Expression On_size_error_statement_list? Not_on_size_error_statement_list? EndCompute
  | exit: 'EXIT'
  | alter: 'ALTER' Procedure_to_procedure+
  | call: 'CALL' Id_or_lit On_overflow_statement_list? EndCall
  | call: 'CALL' Id_or_lit 'NOT' 'ON'? 'EXCEPTION' Statement_list On_overflow_statement_list? EndCall
  | call: 'CALL' Id_or_lit 'ON'? 'EXCEPTION' Statement_list On_overflow_statement_list? EndCall
  | call: 'CALL' Id_or_lit 'ON'? 'EXCEPTION' Statement_list 'NOT' 'ON'? 'EXCEPTION' Statement_list On_overflow_statement_list? EndCall
  | call: 'CALL' Id_or_lit 'USING' Using_parameters On_overflow_statement_list? EndCall
  | call: 'CALL' Id_or_lit 'USING' Using_parameters 'NOT' 'ON'? 'EXCEPTION' Statement_list On_overflow_statement_list? EndCall
  | call: 'CALL' Id_or_lit 'USING' Using_parameters 'ON'? 'EXCEPTION' Statement_list On_overflow_statement_list? EndCall
  | call: 'CALL' Id_or_lit 'USING' Using_parameters 'ON'? 'EXCEPTION' Statement_list 'NOT' 'ON'? 'EXCEPTION' Statement_list On_overflow_statement_list? EndCall
  | \set: 'SET' Set_statement_phrase+
  | stop: 'STOP' Alt_run_literal
  | divide: Divide_statement
  | display: 'DISPLAY' Id_or_lit+
  | display: 'DISPLAY' Id_or_lit+ 'WITH'? 'NO' 'ADVANCING'
  | display: 'DISPLAY' Id_or_lit+ 'UPON' Cobword \ CobwordKeywords
  | display: 'DISPLAY' Id_or_lit+ 'UPON' Cobword \ CobwordKeywords 'WITH'? 'NO' 'ADVANCING'
  | read: 'READ' File_name 'NEXT'? 'RECORD'? Into_identifier? Invalid_key_statement_list? Not_invalid_key_statement_list? At_end_statement_list? Not_at_end_statement_list? EndRead
  | read: 'READ' File_name 'NEXT'? 'RECORD'? Into_identifier? 'KEY' 'IS'? Qualified_data_name Invalid_key_statement_list? Not_invalid_key_statement_list? At_end_statement_list? Not_at_end_statement_list? EndRead
  | string: 'STRING' Delimited_by_phrase+ 'INTO' Identifier With_pointer_identifier? On_overflow_statement_list? Not_on_overflow_statement_list? EndString
  | subtract: Subtract_statement
  | move: Move_statement
  | goTo: Go_to_statement
  | goback: 'GOBACK'
  | add: Add_statement
  | accept: Accept_statement
  | acceptMessage: 'ACCEPT' File_name 'MESSAGE' 'COUNT'
  | acceptCount: 'ACCEPT' File_name 'COUNT'
  | delete: 'DELETE' File_name 'RECORD'? Invalid_key_statement_list? Not_invalid_key_statement_list? EndDelete
  | initialize: 'INITIALIZE' Identifier+
  | initialize: 'INITIALIZE' Identifier+ 'REPLACING' Initialize_replacing_argument+
  | \continue: 'CONTINUE'
  | release: 'RELEASE' Record_name From_identifier?
  | unstring: 'UNSTRING' Identifier 'INTO' Unstring_statement_dst+ With_pointer_identifier? On_overflow_statement_list? Not_on_overflow_statement_list? EndUnString
  | unstring: 'UNSTRING' Identifier 'INTO' Unstring_statement_dst+ With_pointer_identifier? 'TALLYING' 'IN'? Identifier On_overflow_statement_list? Not_on_overflow_statement_list? EndUnString
  | unstring: 'UNSTRING' Identifier 'DELIMITED' 'BY'? 'ALL'? NotAll Id_or_lit Or_all_id_or_lit* 'INTO' Unstring_statement_dst+ With_pointer_identifier? On_overflow_statement_list? Not_on_overflow_statement_list? EndUnString
  | unstring: 'UNSTRING' Identifier 'DELIMITED' 'BY'? 'ALL'? NotAll Id_or_lit Or_all_id_or_lit* 'INTO' Unstring_statement_dst+ With_pointer_identifier? 'TALLYING' 'IN'? Identifier On_overflow_statement_list? Not_on_overflow_statement_list? EndUnString
  | close: 'CLOSE' Close_statement_file_name+
  | \if: If_statement
  | inspect: Inspect_statement
  | sort: 'SORT' File_name On_key_is_phrase+ Collating_sequence? Sort_statement_in Sort_statement_out
  | sort: 'SORT' File_name On_key_is_phrase+ 'WITH'? 'DUPLICATES' 'IN'? 'ORDER'? Collating_sequence? Sort_statement_in Sort_statement_out
  | write: 'WRITE' Record_name From_identifier? Invalid_key_statement_list? Not_invalid_key_statement_list? EndWrite
  | write: 'WRITE' Record_name From_identifier? 'NOT' 'AT'? End_of_page Statement_list Invalid_key_statement_list? Not_invalid_key_statement_list? EndWrite
  | write: 'WRITE' Record_name From_identifier? 'AT'? End_of_page Statement_list Invalid_key_statement_list? Not_invalid_key_statement_list? EndWrite
  | write: 'WRITE' Record_name From_identifier? 'AT'? End_of_page Statement_list 'NOT' 'AT'? End_of_page Statement_list Invalid_key_statement_list? Not_invalid_key_statement_list? EndWrite
  | write: 'WRITE' Record_name From_identifier? Alt_before_after 'ADVANCING'? Page_phrase Invalid_key_statement_list? Not_invalid_key_statement_list? EndWrite
  | write: 'WRITE' Record_name From_identifier? Alt_before_after 'ADVANCING'? Page_phrase 'NOT' 'AT'? End_of_page Statement_list Invalid_key_statement_list? Not_invalid_key_statement_list? EndWrite
  | write: 'WRITE' Record_name From_identifier? Alt_before_after 'ADVANCING'? Page_phrase 'AT'? End_of_page Statement_list Invalid_key_statement_list? Not_invalid_key_statement_list? EndWrite
  | write: 'WRITE' Record_name From_identifier? Alt_before_after 'ADVANCING'? Page_phrase 'AT'? End_of_page Statement_list 'NOT' 'AT'? End_of_page Statement_list Invalid_key_statement_list? Not_invalid_key_statement_list? EndWrite
  | evaluate: 'EVALUATE' Evaluate_condition Also_phrase* When_phrases+ EndEvaluate
  | evaluate: 'EVALUATE' Evaluate_condition Also_phrase* When_phrases+ 'WHEN' 'OTHER' Statement_list EndEvaluate
  | \start: 'START' File_name Invalid_key_statement_list? Not_invalid_key_statement_list? EndStart
  | \start: 'START' File_name 'KEY' 'IS'? Rel_op Qualified_data_name Invalid_key_statement_list? Not_invalid_key_statement_list? EndStart
  | \return: 'RETURN' File_name 'RECORD'? Into_identifier? 'AT'? 'END' Statement_list Not_at_end_statement_list? EndReturn
  | perform: Perform_statement
  | entry: 'ENTRY' Literal Using_data_name_pluslist?
  | cancel: 'CANCEL' Id_or_lit+
  | open: 'OPEN' Open_statement_phrase+
  | multiply: Multiply_statement
  | rewrite: 'REWRITE' Record_name From_identifier? Invalid_key_statement_list? Not_invalid_key_statement_list? EndRewrite
  ;

syntax Communication_io_mode
  = input: 'INPUT' 'TERMINAL'?
  | output: 'OUTPUT'
  ;

syntax Communication_key_phrase = key: 'WITH'? 'KEY' Id_or_lit;

syntax Send_with_phrase
  = withEsi: 'WITH' 'ESI'
  | withEmi: 'WITH' 'EMI'
  | withEgi: 'WITH' 'EGI'
  | with: 'WITH' Identifier
  ;

syntax Send_advancing_phrase = beforeAfter: Alt_before_after 'ADVANCING'? Page_phrase;

syntax Send_replacing_line = replacing: 'REPLACING' 'LINE';

syntax No_data_statement = no: 'NO' 'DATA' Statement;

syntax Not_on_size_error_statement_list = not: 'NOT' 'ON'? 'SIZE' 'ERROR' Statement_list;
syntax On_key_is_phrase
  = ascendingDescending: 'ON'? Alt_ascending_descending Qualified_data_name+
  | ascendingDescending: 'ON'? Alt_ascending_descending 'KEY' 'IS'? Qualified_data_name+
  ;

syntax Date
  = time: 'TIME'
  | day: 'DAY'
  | date: 'DATE'
  | dayOfWeek: 'DAY-OF-WEEK'
  ;
syntax Cobword_rounded = identifier: Identifier 'ROUNDED'?;

syntax Statement_list = statement: Statement+ EndStatementList;

// a statement list extends to the end of the sentence, a scope terminator, or the next phrase of its enclosing statement
syntax EndStatementList
  = () >> "."
  | () >> 'END'
  | () >> 'NOT'
  | () >> 'ELSE'
  | () >> 'WHEN'
  | () >> 'INVALID'
  | () >> 'AT'
  | () >> 'ON'
  | () >> 'OVERFLOW'
  | () >> 'COPY'
  ;
syntax Move_statement
  = moveCorresponding: 'MOVE' Corresponding Identifier 'TO' Identifier+
  | moveTo: 'MOVE' Id_or_lit 'TO' Identifier+
  ;

syntax Id_or_lit_size
  = literal: Literal
  | size: 'SIZE'
  | identifier: Identifier
  ;
syntax Unstring_statement_dst
  = identifier: Identifier
  | identifier: Identifier 'COUNT' 'IN'? Identifier
  | identifier: Identifier 'DELIMITER' 'IN'? Identifier
  | identifier: Identifier 'DELIMITER' 'IN'? Identifier 'COUNT' 'IN'? Identifier
  ;
syntax With_no_rewind = no: 'WITH'? 'NO' 'REWIND';

syntax Tallying_for_id_or_lit = idOrLit: NotAll Id_or_lit Before_after_phrase*;

// operands of INSPECT and UNSTRING can not be ALL literals; ALL is the keyword of the statement
syntax NotAll = () !>> 'ALL ' !>> 'ALL\"';
syntax Perform_statement_4_alts
  = endPerform: Perform_until_phrase Statement_list 'END-PERFORM'
  | procedureName: Procedure_name Through_procedure_name? Perform_until_phrase
  ;

syntax On_size_error_statement_list = size: 'ON'? 'SIZE' 'ERROR' Statement_list;
syntax Alt_all_leading_first
  = \all: 'ALL'
  | first: 'FIRST'
  | leading: 'LEADING'
  ;

syntax Alt_exception_error
  = exception: 'EXCEPTION'
  | error: 'ERROR'
  ;

syntax Not_invalid_key_statement_list = not: 'NOT' 'INVALID' 'KEY'? Statement_list;

syntax Go_to_statement
  = goMoreLabels: 'GO' 'TO'? 'MORE-LABELS'
  | go: 'GO' 'TO'? Procedure_name
  | goDepending: 'GO' 'TO'? Procedure_name+ 'DEPENDING' 'ON'? Identifier
  ;
syntax Or_all_id_or_lit = or: 'OR' 'ALL'? NotAll Id_or_lit;
syntax Alt_run_literal
  = run: 'RUN'
  | literal: Literal
  ;
syntax Perform_statement_2_alts
  = procedureName: Procedure_name Through_procedure_name? Perform_varying_phrase Perform_after_phrase*
  | endPerform: Perform_varying_phrase Statement_list 'END-PERFORM'
  ;
syntax With_pointer_identifier = pointer: 'WITH'? 'POINTER' Identifier;

syntax EndSubtract = 'END-SUBTRACT'?;

// | () >> ".";
syntax Subtract_statement
  = subtractFrom: 'SUBTRACT' Id_or_lit+ 'FROM' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndSubtract
  | subtractFromGiving: 'SUBTRACT' Id_or_lit+ 'FROM' Id_or_lit 'GIVING' Cobword_rounded+ On_size_error_statement_list? Not_on_size_error_statement_list? EndSubtract
  | subtractCorresponding: 'SUBTRACT' Corresponding Identifier 'FROM' Identifier 'ROUNDED'? On_size_error_statement_list? Not_on_size_error_statement_list? EndSubtract
  ;

syntax Inspect_statement
  = inspectTallyingReplacing: 'INSPECT' Identifier 'TALLYING' Tallying_argument+ 'REPLACING' Inspect_replacing_phrase+
  | inspectReplacing: 'INSPECT' Identifier 'REPLACING' Inspect_replacing_phrase+
  | inspectConverting: 'INSPECT' Identifier 'CONVERTING' Id_or_lit 'TO' Id_or_lit Before_after_phrase*
  | inspectTallying: 'INSPECT' Identifier 'TALLYING' Tallying_argument+
  ;
syntax Perform_statement_3_alts
  = procedureName: Procedure_name Through_procedure_name? Cobword_int 'TIMES'
  | endPerform: Cobword_int 'TIMES' Statement_list 'END-PERFORM'
  ;

syntax Rel_op
  = equalTo: Equal_to
  | greaterThanOrEqualTo: Greater_than_or_equal_to
  | greaterThan: Greater_than
  ;
syntax Alt_no_rewind_lock
  = no: 'NO' 'REWIND'
  | lock: 'LOCK'
  ;
syntax Close_statement_options
  = noRewindLock: 'WITH'? Alt_no_rewind_lock
  | reelUnit: Alt_reel_unit Alt_removal_no_rewind?
  ;

syntax Set_src
  = \off: 'OFF'
  | identifier: Identifier
  | literal: Literal
  | \on: 'ON'
  | \true: 'TRUE'
  ;

syntax Alt_procedures_all_procedures
  = allProcedures: 'ALL' 'PROCEDURES'
  | procedureName: Procedure_name+
  // `USE FOR DEBUGGING ON ALL REFERENCES OF A B ALL C`; the names without ALL stay procedure names, as in c1
  | allReferences: Procedure_name* All_references_of (All_references_of | Procedure_name)*
  ;

syntax All_references_of = \all: 'ALL' 'REFERENCES'? 'OF'? NotReferences Identifier;

// REFERENCES is the keyword, not a data name qualified by the identifier (`REFERENCES OF FREC`)
syntax NotReferences = () !>> 'REFERENCES ' !>> 'REFERENCES\n';

syntax Alt_reversed_with_no_rewind
  = reversed: 'REVERSED'
  | withNoRewind: With_no_rewind
  ;

syntax Merge_statement_tail
  = outputProcedure: Output_procedure
  | givingFileNames: Giving_file_names
  ;
syntax Perform_statement_1_alts
  = procedureName: Procedure_name Through_procedure_name?
  | endPerform: Statement_list 'END-PERFORM'
  ;

syntax Set_statement_phrase = identifier: Identifier+ Set_oper Set_src;

syntax Tallying_argument = \for: Identifier 'FOR' Tallying_for_argument+;
syntax Perform_varying_phrase = varying: With_test? 'VARYING' Identifier 'FROM' Id_or_lit 'BY' Id_or_lit 'UNTIL' Expression;