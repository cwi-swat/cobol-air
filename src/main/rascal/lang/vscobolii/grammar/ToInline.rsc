module lang::vscobolii::ToInline

import lang::vscobolii::Main;
import Grammar;
import IO;


set[str] unusedNTs() {
    g = grammar(#VSCobolII);

    set[Symbol] usedIn(Symbol s) {
        // note: /s -- this is different from toInline, because we don't want to remove prods that are still used in * things etc.
        return { u | Symbol u <- g.rules, Production a <- g.rules[u].alternatives, /s := a.symbols };
    }

    set[str] unused = { s.name | Symbol s <- g.rules, s has name, usedIn(s) == {} };

    return unused;
}

map[str, set[str]] toInline() {
    g = grammar(#VSCobolII);

    set[Symbol] usedIn(Symbol s) {
        return { u | Symbol u <- g.rules, Production a <- g.rules[u].alternatives, s in a.symbols || opt(s) in a.symbols };
    }

    map[str, set[str]] inline = ();

    for (Symbol s <- g.rules, s has name) {
        if (choice(_, {_}) := g.rules[s]) { // single alt
            if ({Symbol user} := usedIn(s), user has name) {
                if (user.name notin inline) {
                    inline[user.name] = {};
                }
                if (!(s has name)) {
                    println("NO NAME: <s>");
                }
                inline[user.name] += {s.name};
            }
        }
    }
    return inline;
}

