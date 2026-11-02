module lang::vscobolii::Util

import IO;
import util::Reflective;
import lang::rascal::\syntax::Rascal;
import lang::vscobolii::ToInline;

void inlineDummies() {

    map[str,Prod] defs = ();
    map[str,set[str]] inline = toInline();


    for (loc modul <- |project://cobol-air/src/main/rascal/lang/vscobolii|.ls, modul.extension == "rsc", /^VSC/ := modul.file) {
        start[Module] m = parseModuleWithSpaces(modul);
        for (str u <- inline, str i <- inline[u]) {
            Nonterminal inlineeNT = [Nonterminal]i; 
            if (/(SyntaxDefinition)`<Start _> syntax <Nonterminal nt> = <Prod prod>;` := m, nt := inlineeNT) {
                //assert i notin defs: "bug: multiple defs for <i>";
                // this can happen, if i is inlined in multiple users
                defs[i] = prod;
            }
        }
    }

    for (str x <- defs) {
        println("<x>: <defs[x]>");
    }

    set[str] done = {};

    bool makeDone(Prod p, str sym) {
        println("inlining <sym> in <p>");
        done += {sym};
        return true;
    }


    for (loc modul <- |project://cobol-air/src/main/rascal/lang/vscobolii|.ls, modul.extension == "rsc", /^VSC/ := modul.file) {
        start[Module] m = parseModuleWithSpaces(modul);

        solve (m) {
            m = visit (m) {
                // named prods
                case p:(Prod)`<ProdModifier* ms> <Name n>: <Sym+ ss0> <Nonterminal nt> <Sym* ss1>` 
                    => (Prod)`<ProdModifier* ms> <Name n>: <Sym+ ss0> <Sym* toInsert>  <Sym* ss1>`
                    when "<nt>" in defs, Sym* toInsert := defs["<nt>"].syms, makeDone(p, "<nt>")


                // named prods
                case p:(Prod)`<ProdModifier* ms_> <Name n>: <Nonterminal nt> <Sym* ss1_>` 
                    => (Prod)`<ProdModifier* ms_> <Name n>: <Sym* toInsert> <Sym* ss1_>`
                    when "<nt>" in defs, Sym* toInsert := defs["<nt>"].syms, makeDone(p, "<nt>")

                // unnamed prods
                case p:(Prod)`<ProdModifier* ms1> <Sym* ss01> <Nonterminal nt> <Sym* ss11>` 
                    => (Prod)`<ProdModifier* ms1> <Sym* ss01> <Sym* toInsert>  <Sym* ss11>`
                    when "<nt>" in defs, Sym* toInsert := defs["<nt>"].syms, makeDone(p, "<nt>")

                // optional named
                case p:(Prod)`<ProdModifier* ms2> <Name n>: <Sym+ ss02> <Nonterminal nt>? <Sym* ss12>`
                    => (Prod)`<ProdModifier* ms2> <Name n>: <Sym+ ss02> <Sym* ss12>
                            ' | <ProdModifier* ms2> <Name n>: <Sym+ ss02> <Sym* toInsert>  <Sym* ss12>`
                    when "<nt>" in defs, Sym* toInsert := defs["<nt>"].syms, makeDone(p, "<nt>")

                // optional named
                case p:(Prod)`<ProdModifier* ms2_> <Name n>: <Nonterminal nt>? <Sym* ss12>`
                    => (Prod)`<ProdModifier* ms2_> <Name n>: <Sym* ss12>
                            ' | <ProdModifier* ms2> <Name n>: <Sym* toInsert>  <Sym* ss12>`
                    when "<nt>" in defs, Sym* toInsert := defs["<nt>"].syms, makeDone(p, "<nt>")

                // optional unnamed
                case p:(Prod)`<ProdModifier* ms3> <Sym* ss03> <Nonterminal nt>? <Sym* ss13>`
                    => (Prod)`<ProdModifier* ms3> <Sym* ss03>  <Sym* ss13>
                            ' | <ProdModifier* ms3> <Sym* ss03> <Sym* toInsert>  <Sym* ss13>`
                    when "<nt>" in defs, Sym* toInsert := defs["<nt>"].syms, makeDone(p, "<nt>")
            }
        }

        
        writeFile(modul, "<m>");
    }

    
}

void removeUnused() {
    set[str] unused = unusedNTs();
    for (loc modul <- |project://cobol-air/src/main/rascal/lang/vscobolii|.ls, modul.extension == "rsc", /^VSC/ := modul.file) {
        start[Module] m = parseModuleWithSpaces(modul);
        solve (m) {
            m = top-down visit (m) {
                case h:(Header)`<Tags ts> module <QualifiedName q>  <Import* is0> <Start st> syntax <Nonterminal nt> = <Prod p>; <Import* is1>`
                    => (Header)`<Tags ts> module <QualifiedName q>  <Import* is0> 
                               '<Import* is1>`
                    when "<nt>" in unused
            }
        }
        writeFile(modul, "<m>");
    }
}