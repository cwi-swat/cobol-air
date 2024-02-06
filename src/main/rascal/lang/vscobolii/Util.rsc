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
                defs[i] = prod;
            }
        }
    }

    for (str x <- defs) {
        println("<x>: <defs[x]>");
    }

    for (loc modul <- |project://cobol-air/src/main/rascal/lang/vscobolii|.ls, modul.extension == "rsc", /^VSC/ := modul.file) {
        start[Module] m = parseModuleWithSpaces(modul);

        m = visit (m) {
            // named prods
            case (Prod)`<ProdModifier* ms> <Name n>: <Sym* ss0> <Nonterminal nt> <Sym* ss1>` 
                => (Prod)`<ProdModifier* ms> <Name n>: <Sym* ss0> <Sym* toInsert> <Sym* ss1>`
                when "<nt>" in defs, Sym* toInsert := defs["<nt>"].syms

            // unnamed prods
            case (Prod)`<ProdModifier* ms1> <Sym* ss01> <Nonterminal nt> <Sym* ss11>` 
                => (Prod)`<ProdModifier* ms1> <Sym* ss01> <Sym* toInsert> <Sym* ss11>`
                when "<nt>" in defs, Sym* toInsert := defs["<nt>"].syms

            // optional named
            case (Prod)`<ProdModifier* ms2> <Name n>: <Sym* ss02> <Nonterminal nt>? <Sym* ss12>`
                => (Prod)`<ProdModifier* ms2> <Name n>: <Sym* ss02> <Sym* ss12>
                         '| <ProdModifier* ms2> <Name n>: <Sym* ss02> <Sym* toInsert> <Sym* ss12>`
                when "<nt>" in defs, Sym* toInsert := defs["<nt>"].syms

            // optional unnamed
            case (Prod)`<ProdModifier* ms3> <Sym* ss03> <Nonterminal nt>? <Sym* ss13>`
                => (Prod)`<ProdModifier* ms3> <Sym* ss03> <Sym* ss13>
                         ' | <ProdModifier* ms3> <Sym* ss03> <Sym* toInsert> <Sym* ss13>`
                when "<nt>" in defs, Sym* toInsert := defs["<nt>"].syms
        }

        solve (m) {
            m = top-down visit (m) {
                case h:(Header)`<Tags ts> module <QualifiedName q>  <Import* is0> <Start st> syntax <Nonterminal nt> = <Prod p>; <Import* is1>`
                    => (Header)`<Tags ts> module <QualifiedName q>  <Import* is0> 
                               '<Import* is1>`
                    when "<nt>" in defs   
            }
        }

        writeFile(modul, "<m>");
    }

    
}