module lang::cobol85::\syntax::DataDivision

extend lang::cobol85::\syntax::FileDescriptionEntry;
extend lang::cobol85::\syntax::DataDescriptionEntry;
extend lang::cobol85::\syntax::CommunicationSection;

keyword CobwordKeywords
    = 'DATA'
    | 'DIVISION'
    | 'FILE'
    | 'LINKAGE'
    | 'SECTION'
    | 'WORKING-STORAGE'
    ;

syntax FileSectionEntry
    = fd: AltFdSd Id FileAndSortDescriptionEntryClause* "." DataDescriptionEntry+
    | fd: AltFdSd Id CopyStatement DataDescriptionEntry*
    // the clauses come from a copybook
    ;

// the sections of the data division, in any order; a checker rejects the orders COBOL does not allow
syntax DataDivision = dataDivision: 'DATA' 'DIVISION' "." DataSection*;

syntax DataSection
    = file: 'FILE' 'SECTION' "." FileSectionEntry*
    | workingStorage: 'WORKING-STORAGE' 'SECTION' "." DataDescriptionEntry*
    | linkage: 'LINKAGE' 'SECTION' "." DataDescriptionEntry*
    | communication: CommunicationSection
    ;
