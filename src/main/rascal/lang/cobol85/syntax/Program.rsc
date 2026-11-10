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
@synopsis{Composing an entire COBOL program from its constituents}
@description{
This module puts the four divisions together into a complete source program: the IDENTIFICATION DIVISION with
PROGRAM-ID and the optional COMMON and INITIAL attributes, followed by the environment, data and procedure
divisions, each optional, and REPLACE directives after the PROGRAM-ID paragraph. Nested programs follow the
procedure division of the program that contains them, and each ends with END PROGRAM and its name; an outermost
program needs END PROGRAM only when it contains nested programs. The module also brings in the intrinsic
functions from the Functions module, so they can be used in expressions.
}
module lang::cobol85::\syntax::Program

extend lang::cobol85::\syntax::ProcedureDivision;
extend lang::cobol85::\syntax::IdentificationDivision;
extend lang::cobol85::\syntax::EnvironmentDivision;
extend lang::cobol85::\syntax::DataDivision;
extend lang::cobol85::\syntax::Expression;
extend lang::cobol85::\syntax::Functions;

keyword CobwordKeywords
    = 'COMMON'
    | 'DIVISION'
    | 'END'
    | 'INITIAL'
    | 'IS'
    | 'PROGRAM'
    | 'PROGRAM-ID'
    ;

syntax CommonInitial
    = initial: 'INITIAL' 'COMMON'?
    | common: 'COMMON' 'INITIAL'?
    ;

syntax NestedCobolSourceProgram = programId: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Id ('IS'? CommonInitial 'PROGRAM'?)? "."? ReplaceDirective* IdentificationDivisionContent EnvironmentDivision? DataDivision? ProcedureDivision? NestedCobolSourceProgram* 'END' 'PROGRAM' Id ".";

syntax CobolSourceProgram = programId: Identification 'DIVISION' "." 'PROGRAM-ID' "."? Id ('IS'? CommonInitial 'PROGRAM'?)? "."? ReplaceDirective* IdentificationDivisionContent EnvironmentDivision? DataDivision? ProcedureDivision? (NestedCobolSourceProgram* 'END' 'PROGRAM' Id ".")?;
