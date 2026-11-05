module lang::cobol85::\syntax::ProcedureDivision

extend lang::cobol85::\syntax::Statement;
extend lang::cobol85::\syntax::Expression;

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

syntax ProcedureDivision
    = procedureDivision: 'PROCEDURE' 'DIVISION' UsingPhrase Paragraphs SectionWithHeader*
    | procedureDivision: 'PROCEDURE' 'DIVISION' UsingPhrase 'DECLARATIVES' "." DeclarativesContent+ 'END' 'DECLARATIVES' "." Paragraphs SectionWithHeader*
    ;

syntax UsingPhrase
    = copy: CopyStatement
    | copy: 'USING' Id* CopyStatement
    | using: UsingDataNamePluslist? "."
    ;

syntax SectionWithHeader = sectionHeader: SectionHeader "." Paragraphs;

syntax Paragraphs = items: ParagraphItem* Paragraph*;

syntax Paragraph
    = items: ParagraphName "." ParagraphItem*
    | go: ParagraphName "." 'GO' 'TO'? "."
    ;

syntax ParagraphItem
    = sentence: Sentence
    | replaceDirective: ReplaceDirective
    ;

syntax Sentence
    = statementList: StatementList "."+
    | copy: StatementList? CopyStatement
    ;

syntax DeclarativesContent = sectionHeader: SectionHeader "." UseStatement "." Paragraphs;

syntax SectionHeader = section: SectionName 'SECTION' PriorityNumber?;
