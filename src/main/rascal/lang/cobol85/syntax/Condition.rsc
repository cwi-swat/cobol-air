 module lang::cobol85::\syntax::Condition  extend lang::cobol85::\syntax::Expression; 

// the reserved words of this module
keyword CobwordKeywords
  = 'ALPHABETIC'
  | 'ALPHABETIC-LOWER'
  | 'ALPHABETIC-UPPER'
  | 'AND'
  | 'DBCS'
  | 'EQUAL'
  | 'GREATER'
  | 'IS'
  | 'KANJI'
  | 'LESS'
  | 'NEGATIVE'
  | 'NOT'
  | 'NUMERIC'
  | 'OR'
  | 'POSITIVE'
  | 'THAN'
  | 'THEN'
  | 'TO'
  | 'ZERO'
  | 'ZEROES'
  | 'ZEROS'
  ;

syntax And_or_combinable_condition =
  \and-or-combinable-condition: Alt_and_or Relational_operator? Combinable_condition 
  ;

syntax Relational_operator_tail =
   \relational-operator-tail-c2: 'LESS' !>> [A-Za-z0-9\-] Than 'OR' 'EQUAL' 'TO'? 
  | \relational-operator-tail-c4: "\>=" 
  |  \relational-operator-tail-c1: 'GREATER' !>> [A-Za-z0-9\-] Than 'OR' 'EQUAL' 'TO'? 
  |  \relational-operator-tail-c3: "\<" "=" 
  |  \relational-operator-tail-c5: 'NOT'? Relational_operator_rest 
  ; 
// GREATER and LESS end at a word boundary: `EQUAL TO ZEROS AND GREATERZERO` has the condition name GREATERZERO
syntax Relational_operator_rest =
   \relational-operator-rest-c3: 'LESS' !>> [A-Za-z0-9\-] Than 
  | \relational-operator-rest-c2: "\>" 
  | \relational-operator-rest-c4: "\<" 
  | \relational-operator-rest-c5: Equal_to 
  |  \relational-operator-rest-c1: 'GREATER' !>> [A-Za-z0-9\-] Than 
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
  singleCondition: Combinable_condition 
  |  \condition-c1: Combinable_condition And_or_combinable_condition+ 
  ; 
syntax Relational_operator =
  \relational-operator: 'IS'? Relational_operator_tail 
  ;

syntax Combinable_condition =
  simpleCondition: Simple_condition 
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
  | bareExpression: Arithmetic_expression 
  // condition brackets only around real conditions; brackets around a bare expression are expression brackets
  |  \simple-condition-c4: "(" Condition!singleCondition ")"
  |  \simple-condition-c4: "(" Combinable_condition!simpleCondition ")"
  |  \simple-condition-c4: "(" Simple_condition!bareExpression ")"
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
