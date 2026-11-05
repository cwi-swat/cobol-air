module lang::cobol85::Parser

import lang::cobol85::\syntax::Main;
import lang::cobol85::\syntax::Copybook;
import lang::cobol85::\syntax::Preprocess;
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


