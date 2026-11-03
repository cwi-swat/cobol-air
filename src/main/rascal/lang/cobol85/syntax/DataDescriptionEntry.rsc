module lang::cobol85::\syntax::DataDescriptionEntry

extend lang::cobol85::\syntax::ConfigurationSection;
extend lang::cobol85::\syntax::Lexical;
extend lang::cobol85::\syntax::Expression;

// the reserved words of this module
keyword CobwordKeywords
  = 'BINARY'
  | 'BLANK'
  | 'BY'
  | 'CHARACTER'
  | 'COMP'
  | 'COMP-1'
  | 'COMP-2'
  | 'COMP-3'
  | 'COMP-4'
  | 'COMPUTATIONAL'
  | 'COMPUTATIONAL-1'
  | 'COMPUTATIONAL-2'
  | 'COMPUTATIONAL-3'
  | 'COMPUTATIONAL-4'
  | 'DEPENDING'
  | 'DISPLAY'
  | 'DISPLAY-1'
  | 'EXTERNAL'
  | 'FILLER'
  | 'GLOBAL'
  | 'INDEX'
  | 'INDEXED'
  | 'IS'
  | 'JUST'
  | 'JUSTIFIED'
  | 'KEY'
  | 'LEADING'
  | 'LEFT'
  | 'OCCURS'
  | 'ON'
  | 'PACKED-DECIMAL'
  | 'PIC'
  | 'PICTURE'
  | 'POINTER'
  | 'REDEFINES'
  | 'RENAMES'
  | 'RIGHT'
  | 'SEPARATE'
  | 'SIGN'
  | 'SYNC'
  | 'SYNCHRONIZED'
  | 'TIMES'
  | 'TO'
  | 'TRAILING'
  | 'USAGE'
  | 'WHEN'
  | 'ZERO'
  | 'ZEROES'
  | 'ZEROS'
  ;

syntax Integer_to = to: Integer 'TO';

syntax Picture
  = pic: 'PIC'
  | picture: 'PICTURE'
  ;
syntax Zeroes
  = zeros: 'ZEROS'
  | zero: 'ZERO'
  | zeroes: 'ZEROES'
  ;
syntax External_clause = external: 'IS'? 'EXTERNAL';
syntax Data_description_entry
  = // the follow restriction ensures that digits are eaten up by picture strings.
   entry: Num!decimal!signedDecimal!signedInteger !>> [.,] Alt_data_name_filler? Data_description_entry_clause* "."?
  | copy: Copy_statement
  | replaceDirective: Replace_directive
  ;
syntax Alt_left_right
  = \left: 'LEFT'
  | \right: 'RIGHT'
  ;

syntax Justified
  = justified: 'JUSTIFIED'
  | just: 'JUST'
  ;
syntax Synchronized
  = synchronized: 'SYNCHRONIZED'
  | sync: 'SYNC'
  ;

syntax Data_description_entry_clause
  = externalClause: External_clause
  | globalClause: Global_clause
  | synchronized: Synchronized Alt_left_right?
  | blank: 'BLANK' 'WHEN'? Zeroes
  | sign: Alt_leading_trailing
  | sign: 'SIGN' 'IS'? Alt_leading_trailing
  | sign: Alt_leading_trailing 'SEPARATE' 'CHARACTER'?
  | sign: 'SIGN' 'IS'? Alt_leading_trailing 'SEPARATE' 'CHARACTER'?
  | values: Values Are? Literal_through_literal+
  | picture: Picture 'IS'? Picture_string
  | redefines: 'REDEFINES' Id
  | usage: Usage
  | usage: 'USAGE' 'IS'? Usage
  | renames: 'RENAMES' Qualified_data_name
  | renames: 'RENAMES' Qualified_data_name Through Qualified_data_name
  | justified: Justified 'RIGHT'?
  | occursClause: Occurs_clause
  ;

syntax Global_clause = global: 'IS'? 'GLOBAL';

syntax Alt_leading_trailing
  = trailing: 'TRAILING'
  | leading: 'LEADING'
  ;
syntax Usage
  = comp1: 'COMP-1'
  | display: 'DISPLAY'
  | index: 'INDEX'
  | comp3: 'COMP-3'
  | comp2: 'COMP-2'
  | pointer: 'POINTER'
  | computational4: 'COMPUTATIONAL-4'
  | computational1: 'COMPUTATIONAL-1'
  | computational2: 'COMPUTATIONAL-2'
  | binary: 'BINARY'
  | packedDecimal: 'PACKED-DECIMAL'
  | comp: 'COMP'
  | computational: 'COMPUTATIONAL'
  | comp4: 'COMP-4'
  | display1: 'DISPLAY-1'
  | computational3: 'COMPUTATIONAL-3'
  ;
syntax Indexed_by = indexed: 'INDEXED' 'BY'? Id+;

syntax Alt_data_name_filler
  = filler: 'FILLER'
  | dataName: Id
  ;

syntax Occurs_clause
  = occursDepending: 'OCCURS' Integer_to? Integer 'TIMES'? 'DEPENDING' 'ON'? Qualified_data_name Occurs_clause_key* Indexed_by?
  | occurs: 'OCCURS' Integer 'TIMES'? Occurs_clause_key* Indexed_by?
  ;

syntax Occurs_clause_key = ascendingDescending: Alt_ascending_descending 'KEY'? 'IS'? Qualified_data_name+;