module lang::cobol85::\syntax::Main 


extend lang::cobol85::\syntax::Program;
extend lang::cobol85::\syntax::ProcedureDivision;
extend lang::cobol85::\syntax::IdentificationDivision;
extend lang::cobol85::\syntax::Condition;
extend lang::cobol85::\syntax::DataDescriptionEntry;
extend lang::cobol85::\syntax::ConfigurationSection;
extend lang::cobol85::\syntax::InputOutputSection;
extend lang::cobol85::\syntax::DataDivision;
extend lang::cobol85::\syntax::Lexical;
extend lang::cobol85::\syntax::Statement;
extend lang::cobol85::\syntax::Expression;
extend lang::cobol85::\syntax::EnvironmentDivision;
extend lang::cobol85::\syntax::FileDescriptionEntry;
extend lang::cobol85::\syntax::ReportSection;

// a source file can contain several programs, each ending with END PROGRAM
start syntax Cobol85 = Cobol_source_program+;