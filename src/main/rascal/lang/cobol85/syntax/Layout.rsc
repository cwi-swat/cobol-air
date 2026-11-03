module lang::cobol85::\syntax::Layout

layout LAYOUTLIST = LAYOUT* !>> [\t-\n\ ,;\uE000];

// the preprocessor fills the margins (columns 1-6 and from column 73) with \uE000, so the indicator column follows
// six of them
lexical LAYOUT
    = @category="comment" ^"\uE000\uE000\uE000\uE000\uE000\uE000*" ![\n]* !>> ![\n]$
    | @category="comment" ^"\uE000\uE000\uE000\uE000\uE000\uE000/" ![\n]* !>> ![\n]$
    | ^"\uE000\uE000\uE000\uE000\uE000\uE000-"
    // a line continuation
    | [\t-\n\ ;,]
    // the margins; the editor shows the original sequence numbers and identification texts there, as comments
    | @category="comment" [\uE000]+ !>> [\uE000]
    ;
