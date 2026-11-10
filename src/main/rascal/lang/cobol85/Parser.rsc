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
module lang::cobol85::Parser

import lang::cobol85::\syntax::Main;
import lang::cobol85::\syntax::Copybook;
import lang::cobol85::Preprocess;
import ParseTree;
import IO;
import Set;
import Exception;

start[Cobol85] parseCobol85(loc org, bool allowAmbiguity=false, bool allowRecovery=false, bool doPreprocess=true) {
    str src = readFile(org);
    return parseCobol85(src, org, allowAmbiguity=allowAmbiguity, allowRecovery=allowRecovery, doPreprocess=doPreprocess);
}

start[Cobol85] parseCobol85(str src, loc org, bool allowAmbiguity=false, bool allowRecovery=false, bool doPreprocess=true) {
    return parse(#start[Cobol85], doPreprocess ? preprocess(src) : src, org, allowAmbiguity=allowAmbiguity, allowRecovery=allowRecovery);
}

start[Copybook] parseCobol85Copybook(loc org, bool allowRecovery=false, bool doPreprocess=true) {
    return parseCobol85Copybook(readFile(org), org, allowRecovery=allowRecovery, doPreprocess=doPreprocess);
}

@synopsis{Parses a copybook, which may fit several alternatives of ((Copybook))}
@description{
When the copybook fits several alternatives of `Copybook` the result is a forest with an `amb` at the top. Any other
ambiguity, below those alternatives or between two parses of the same alternative, throws `Ambiguity` as `parse` does.
}
start[Copybook] parseCobol85Copybook(str src, loc org, bool allowRecovery=false, bool doPreprocess=true) {
    start[Copybook] t = parse(#start[Copybook], doPreprocess ? preprocess(src) : src, org, allowAmbiguity=true, allowRecovery=allowRecovery);
    set[Tree] alternatives = amb(set[Tree] alts) := t.top ? alts : {t.top};

    if (size({a.prod | a <- alternatives}) < size(alternatives)) {
        throw Ambiguity(t.top.src, "<type(typeOf(t.top), ())>", "<t.top>");
    }

    for (Tree a <- alternatives, /Tree deeper:amb(_) := a) {
       throw Ambiguity(deeper.src, "<type(typeOf(deeper), ())>", "<deeper>");
    }

    return t;
}


