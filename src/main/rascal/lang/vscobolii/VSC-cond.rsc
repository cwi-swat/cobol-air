module lang::vscobolii::\VSC-cond 

extend lang::vscobolii::\VSC-expr;


syntax Greater =
  greater: "GREATER" !>> [\- 0-9 A-Z _ a-z] Than 
  ;

syntax Greater_than_or_equal_to_3 =
  \greater-than-or-equal-to-3: "NOT" !>> [\- 0-9 A-Z _ a-z] "\<" 
  ;

syntax Is_not =
  \is-not: "IS"? "NOT"? 
  ;

syntax And_or_combinable_condition =
  \and-or-combinable-condition: Alt_and_or Relational_operator? Combinable_condition 
  ;

syntax Relational_operator_tail =
  \relational-operator-tail-c2: Less_equal 
  | \relational-operator-tail-c4: "\>=" 
  | \relational-operator-tail-c1: Greater_equal 
  | \relational-operator-tail-c3: Less_equal_2 
  | \relational-operator-tail-c5: Not_relational_operator_rest 
  ;

syntax Combined_conditions =
  \combined-conditions: Combinable_condition And_or_combinable_condition+ 
  ;

syntax Class_condition =
  \class-condition: Identifier Is_or_is_not Class_type 
  ;

syntax Relational_operator_rest =
  \relational-operator-rest-c3: Less 
  | \relational-operator-rest-c2: "\>" 
  | \relational-operator-rest-c4: "\<" 
  | \relational-operator-rest-c5: Equal_to 
  | \relational-operator-rest-c1: Greater 
  ;

syntax Not_is =
  \not-is: "NOT" !>> [\- 0-9 A-Z _ a-z] "IS" !>> [\- 0-9 A-Z _ a-z] 
  ;

syntax Greater_than_or_equal_to =
  \greater-than-or-equal-to-c1: Greater_than_or_equal_to_1 
  | \greater-than-or-equal-to-c2: Greater_than_or_equal_to_2 
  | \greater-than-or-equal-to-c4: "\>=" 
  | \greater-than-or-equal-to-c3: Greater_than_or_equal_to_3 
  ;

syntax Negated_simple_conditions =
  \negated-simple-conditions: "NOT" !>> [\- 0-9 A-Z _ a-z] Combinable_condition 
  ;

syntax Greater_equal =
  \greater-equal: "GREATER" !>> [\- 0-9 A-Z _ a-z] Than "OR" !>> [\- 0-9 A-Z _ a-z] "EQUAL" !>> [\- 0-9 A-Z _ a-z] "TO"? 
  ;

syntax Simple_condition_1 =
  \simple-condition-1: "(" Condition ")" 
  ;

syntax Not_relational_operator_rest =
  \not-relational-operator-rest: "NOT"? Relational_operator_rest 
  ;

syntax Is_or_is_not =
  \is-or-is-not-c1: Not_is 
  | \is-or-is-not-c2: Is_not 
  ;

syntax Greater_than =
  \greater-than-c2: "\>" 
  | \greater-than-c1: Greater_than_1 
  ;

syntax Sign_condition =
  \sign-condition: Arithmetic_expression Is_or_is_not Sign_type 
  ;

syntax Less =
  less: "LESS" !>> [\- 0-9 A-Z _ a-z] Than 
  ;

syntax Relation_condition =
  \relation-condition: Arithmetic_expression Relational_operator Simple_condition 
  ;

syntax Greater_than_1 =
  \greater-than-1: "GREATER" !>> [\- 0-9 A-Z _ a-z] "THAN"? 
  ;

syntax Greater_than_or_equal_to_1 =
  \greater-than-or-equal-to-1: "GREATER" !>> [\- 0-9 A-Z _ a-z] "THAN"? "OR" !>> [\- 0-9 A-Z _ a-z] "EQUAL" !>> [\- 0-9 A-Z _ a-z] "TO"? 
  ;

syntax Condition_name_reference =
  \condition-name-reference: Condition_name In_data_or_file_or_mnemonic_name* Subscript_parentheses* 
  ;

syntax Condition =
  \condition-c2: Combinable_condition 
  | \condition-c1: Combined_conditions 
  ;

syntax Greater_than_or_equal_to_2 =
  \greater-than-or-equal-to-2: "NOT" !>> [\- 0-9 A-Z _ a-z] "LESS" !>> [\- 0-9 A-Z _ a-z] "THAN"? 
  ;

syntax Relational_operator =
  \relational-operator: "IS"? Relational_operator_tail 
  ;

syntax Combinable_condition =
  \combinable-condition-c1: Simple_condition 
  | \combinable-condition-c2: Negated_simple_conditions 
  ;

syntax Sign_type =
  \sign-type-c3: "ZERO" !>> [\- 0-9 A-Z _ a-z] 
  | \sign-type-c4: "ZEROES" !>> [\- 0-9 A-Z _ a-z] 
  | \sign-type-c5: "ZEROS" !>> [\- 0-9 A-Z _ a-z] 
  | \sign-type-c1: "POSITIVE" !>> [\- 0-9 A-Z _ a-z] 
  | \sign-type-c2: "NEGATIVE" !>> [\- 0-9 A-Z _ a-z] 
  ;

syntax Simple_condition =
  \simple-condition-c2: Relation_condition 
  | \simple-condition-c5: Arithmetic_expression 
  | \simple-condition-c4: Simple_condition_1 
  | \simple-condition-c1: Class_condition 
  | \simple-condition-c3: Sign_condition 
  ;

syntax Less_equal =
  \less-equal: "LESS" !>> [\- 0-9 A-Z _ a-z] Than "OR" !>> [\- 0-9 A-Z _ a-z] "EQUAL" !>> [\- 0-9 A-Z _ a-z] "TO"? 
  ;

syntax Less_equal_2 =
  \less-equal-2: "\<" "=" 
  ;

syntax Alt_and_or =
  \alt-and-or-c2: "OR" !>> [\- 0-9 A-Z _ a-z] 
  | \alt-and-or-c1: "AND" !>> [\- 0-9 A-Z _ a-z] 
  ;

syntax Class_type =
  \class-type-c4: "ALPHABETIC-UPPER" !>> [\- 0-9 A-Z _ a-z] 
  | \class-type-c5: Class_name 
  | \class-type-c6: "DBCS" !>> [\- 0-9 A-Z _ a-z] 
  | \class-type-c7: "KANJI" !>> [\- 0-9 A-Z _ a-z] 
  | \class-type-c3: "ALPHABETIC-LOWER" !>> [\- 0-9 A-Z _ a-z] 
  | \class-type-c2: "ALPHABETIC" !>> [\- 0-9 A-Z _ a-z] 
  | \class-type-c1: "NUMERIC" !>> [\- 0-9 A-Z _ a-z] 
  ;

syntax Than =
  \than-c2: "THEN"? 
  | \than-c1: "THAN" !>> [\- 0-9 A-Z _ a-z] 
  ;
