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
module lang::cobol85::\syntax::Layout

layout LAYOUTLIST = LAYOUT* !>> [\t-\n\ ,;\uE000];

// the preprocessor fills the margins (columns 1-6 and from column 73) with \uE000, so the indicator column follows
// six of them
lexical LAYOUT
    = @category="comment" ^"\uE000\uE000\uE000\uE000\uE000\uE000*" ![\n]* !>> ![\n]$
    | @category="comment" ^"\uE000\uE000\uE000\uE000\uE000\uE000/" ![\n]* !>> ![\n]$
    // the indicator of a continuation line; its left margin is the margin alternative below, like on any other line
    | [\uE000] << "-"
    | [\t-\n\ ;,]
    // the margins; the editor shows the original sequence numbers and identification texts there, as comments
    | @category="comment" [\uE000]+ !>> [\uE000]
    ;
