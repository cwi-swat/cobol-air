 module lang::vscobolii::\VSC-cond  extend lang::vscobolii::\VSC-expr; 
syntax And_or_combinable_condition =
  \and-or-combinable-condition: Alt_and_or Relational_operator? Combinable_condition 
  ;

syntax Relational_operator_tail =
   \relational-operator-tail-c2: 'LESS' Than 'OR' 'EQUAL' 'TO'? 
  | \relational-operator-tail-c4: "\>=" 
  |  \relational-operator-tail-c1: 'GREATER' Than 'OR' 'EQUAL' 'TO'? 
  |  \relational-operator-tail-c3: "\<" "=" 
  |  \relational-operator-tail-c5: 'NOT'? Relational_operator_rest 
  ; 
syntax Relational_operator_rest =
   \relational-operator-rest-c3: 'LESS' Than 
  | \relational-operator-rest-c2: "\>" 
  | \relational-operator-rest-c4: "\<" 
  | \relational-operator-rest-c5: Equal_to 
  |  \relational-operator-rest-c1: 'GREATER' Than 
  ; 
syntax Greater_than_or_equal_to =
   \greater-than-or-equal-to-c1: 'GREATER' 'THAN'? 'OR' 'EQUAL' 'TO'? 
  |  \greater-than-or-equal-to-c2: 'NOT' 'LESS' 'THAN'? 
  | \greater-than-or-equal-to-c4: "\>=" 
  |  \greater-than-or-equal-to-c3: 'NOT' "\<" 
  ; 
syntax Is_or_is_not =
   \is-or-is-not-c1: 'NOT' 'IS' 
  |  \is-or-is-not-c2: 'IS'? 'NOT'? 
  ;

syntax Greater_than =
  \greater-than-c2: "\>" 
  |  \greater-than-c1: 'GREATER' 'THAN'? 
  ; 
syntax Condition =
  \condition-c2: Combinable_condition 
  |  \condition-c1: Combinable_condition And_or_combinable_condition+ 
  ; 
syntax Relational_operator =
  \relational-operator: 'IS'? Relational_operator_tail 
  ;

syntax Combinable_condition =
  \combinable-condition-c1: Simple_condition 
  |  \combinable-condition-c2: 'NOT' Combinable_condition 
  ;

syntax Sign_type =
  \sign-type-c3: 'ZERO' 
  | \sign-type-c4: 'ZEROES' 
  | \sign-type-c5: 'ZEROS' 
  | \sign-type-c1: 'POSITIVE' 
  | \sign-type-c2: 'NEGATIVE' 
  ;

syntax Simple_condition =
   \simple-condition-c2: Arithmetic_expression Relational_operator Simple_condition 
  | \simple-condition-c5: Arithmetic_expression 
  |  \simple-condition-c4: "(" Condition ")" 
  |  \simple-condition-c1: Identifier Is_or_is_not Class_type 
  |  \simple-condition-c3: Arithmetic_expression Is_or_is_not Sign_type 
  ; 
syntax Alt_and_or =
  \alt-and-or-c2: 'OR' 
  | \alt-and-or-c1: 'AND' 
  ;

syntax Class_type =
  \class-type-c4: 'ALPHABETIC-UPPER' 
  | \class-type-c5: Class_name 
  | \class-type-c6: 'DBCS' 
  | \class-type-c7: 'KANJI' 
  | \class-type-c3: 'ALPHABETIC-LOWER' 
  | \class-type-c2: 'ALPHABETIC' 
  | \class-type-c1: 'NUMERIC' 
  ;

syntax Than =
  \than-c2: 'THEN'? 
  | \than-c1: 'THAN' 
  ;
