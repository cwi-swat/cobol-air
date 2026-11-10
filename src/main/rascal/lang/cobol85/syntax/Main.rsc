@license{
Copyright (c) 2026, CWI - Software Analysis and Transformation

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
}
@synopsis{The complete COBOL-85 grammar, with the start nonterminal `Cobol85` for a source file.}
@description{
This is the top module of the grammar. It extends all other syntax modules, including the optional Report
Writer, and defines the start nonterminal `Cobol85`: a source file is a list of one or more programs, each ending
with or without END PROGRAM. Clients parse with this start nonterminal, preferably through the parse functions of
the Parser module, which run the preprocessor first; the preprocessor fills the margins and glues continuation
lines in the way the grammar expects. The Copybook module offers a second start nonterminal for copybooks.
}
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
start syntax Cobol85 = CobolSourceProgram+;
