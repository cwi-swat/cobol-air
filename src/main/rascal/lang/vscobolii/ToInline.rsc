module lang::vscobolii::ToInline

import lang::vscobolii::Main;
import Grammar;

map[str, set[str]] toInline() {
    g = grammar(#VSCobolII);

    set[Symbol] usedIn(Symbol s) {
        return { u | Symbol u <- g.rules, Production a <- g.rules[u].alternatives, s in a.symbols || opt(s) in a.symbols };
    }

    map[str, set[str]] inline = ();

    for (Symbol s <- g.rules) {
        if (choice(_, {_}) := g.rules[s]) { // single alt
            if ({Symbol user} := usedIn(s)) {
                if (user.name notin inline) {
                    inline[user.name] = {};
                }
                inline[user.name] += {s.name};
            }
        }
    }
    return inline;
}

