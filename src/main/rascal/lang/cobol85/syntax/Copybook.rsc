module lang::cobol85::\syntax::Copybook

extend lang::cobol85::\syntax::Main;

// A copybook is a fragment of a program, so its kind depends on where it is copied. This start nonterminal accepts
// the fragments that are complete constructs; a fragment that is only part of an entry or a statement (the end of a
// data description entry, a single operand) does not parse on its own. Copybooks may fit several alternatives.
start syntax Copybook
    = procedure: Paragraphs SectionWithHeader*
    | dataEntries: DataDescriptionEntry+
    | fileClauses: FileAndSortDescriptionEntryClause+ "."
    | environment: EnvironmentEntry+
    // the rest of a program after `ENVIRONMENT DIVISION.`, as in `COPY K6SCA.`
    | divisions: EnvironmentEntry* DataDivision ProcedureDivision?
    | specialNames: SpecialNamesParagraphPhrase+ SpecialNamesParagraphClause* "."?
    | specialNames: SpecialNamesParagraphClause+ "."?
    ;
