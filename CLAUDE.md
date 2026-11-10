# cobol-air

Rascal grammar and analysis library for COBOL-85 (IBM VS COBOL II dialect). Grammar modules are in
`src/main/rascal/lang/cobol85/syntax`, the parser entry points in `lang::cobol85::Parser`, the preprocessor in
`lang::cobol85::Preprocess`, and the tests in `lang::cobol85::test`.

## Starting a Rascal REPL

- Use the Rascal jar whose version matches `pom.xml`, from `~/.m2/repository/org/rascalmpl/rascal/<version>/`.
- Start it from the project root, in the background, reading commands from a file:

  ```
  tail -n +1 -f repl.in | java -Xss120M -Xmx4G -jar "${HOME}/.m2/repository/org/rascalmpl/rascal/<version>/rascal-<version>.jar" > repl.log 2>&1
  ```

  Without `-Xss120M`, importing the grammar fails with `RascalStackOverflowError`.
- To send a command, append a line to `repl.in` and wait for the next `rascal>` prompt in `repl.log`. Always wait with a
  timeout: when the REPL thinks a command is incomplete, it silently waits for more input.
- Do not use `kill -INT` to clear a stuck command: it kills the REPL. Restart it instead.
- Run each small experimental grammar in a fresh REPL: generating several of them in one session has given spurious
  `Ambiguity` errors.

## Grammar style

- Over-approximate. The grammar may accept more than COBOL; a later checker stage rejects the extra sentences. Do not
  split nonterminals or add context-specific copies just to reject input that is invalid but unambiguous. Ambiguities
  and parse errors on valid code must still be fixed in the grammar.
- Keep few nonterminals and simple, stable tree shapes; back ends depend on them. When a choice depends on context, keep
  one reading and let the back ends decide. Add new alternatives rather than reshape old ones. Reuse existing
  nonterminals instead of cloning them.
- Disambiguate with longest-match follow restrictions and empty guard nonterminals (`syntax EndIf = () !>> ...`, as in
  `EndIf`, `NotAll`, `NotFigurative`, `NotArithmetic`), not with spacing rules.
- Conditions and arithmetic are one recursive `Expression` with `>` priorities and left/right/non-assoc (COBOL-85
  precedence). Statements are single rules with a phrase list in any order (`Arithmetic_phrase*`, `Io_phrase*`, ...).
- Names: nonterminals are CamelCase without `_`. Production labels are camelCase English names taken from the rule's
  literals (`'GREATER' 'THAN'?` is `greaterThan`), with no nonterminal prefix, the shortest name unique within the
  nonterminal; rules without literals are named after their main nonterminal; escape Rascal keywords (`\if`).
- Reserved words: every module declares `keyword CobwordKeywords` for the words its own productions use (sorted, one per
  line). A new keyword goes into every module that uses it.
- Definition order within a module: dependency order, top nonterminal first; the members of a strongly connected
  component next to each other; a nonterminal right after its last user in the module, so that what the current
  definition uses and the next one does not comes in between; `keyword CobwordKeywords` last. Comments directly above
  a definition belong to it.
- New features go in separate modules (e.g. `Functions.rsc`), with a comment on when the feature was introduced.
- The preprocessor keeps all offsets and fills the margins (columns 1-6 and from 73) with U+E000. Any lexical or
  restriction that looks for whitespace must also accept `\uE000`.
- For mechanical edits to `.rsc` modules (renaming labels or nonterminals), work on parse trees: `parseModuleWithSpaces`
  from `util::Reflective`, `visit`, then `treeDiff` from `analysis::diff::edits::HiFiTreeDiff` and `executeTextEdits`.
  Do not use regular expressions.
- In Rascal code, build strings with templates (`"<a><b>"`) and lists with splicing (`[x, *ys]`), not with `+`.

## Diagnosing ambiguities

- Find the first ambiguity quickly with `firstAmbiguity(#start[Cobol85], preprocess(readFile(file)))`, then explain it
  with `diagnose(tree)` from `analysis::grammars::Ambiguity`. A full parse followed by `diagnose` crashes on `amb` nodes
  without source locations.
- Register every ambiguity found, once it is fixed, as an example in `src/main/rascal/lang/cobol85/test/regressions.dra`
  with the smallest nonterminal that shows it (`Statement`, `Sentence`, `Expression`, ...), preferably with the real
  NIST lines. Format: `<input, sort("X"), nothing(), "no amb.">` appended to `m.examples`; read and write it with
  `readTextValueFile(#Model, loc)` / `writeTextValueFile` (the calling module must import `ParseTree` and
  `util::Maybe`). Check each example with `reparse(#Cobol85, sym, text)` from `analysis::grammars::dramb::Util` first;
  the regression test fails on any stored example that is still ambiguous.
- Snippets with comment lines or margins: write the fixed-format lines, run `preprocess`, and trim the leading and
  trailing U+E000 and whitespace.

## Known Rascal pitfalls

Found with 0.43.0 and 0.43.1-RC1; recheck them when the Rascal version in `pom.xml` changes.

- A follow restriction with a sequence condition, `!>> ([,][0-9])`, compiles but the parser generator silently drops
  it. Use a string literal: `!>> ",0"`.
- `!label` only accepts labels that match `[a-z][0-9A-Z_a-z]*`.
- Priorities do not filter a lower-priority prefix rule in a rightmost position, nor a postfix rule in a leftmost
  position. Use guard nonterminals (`NotEqualSign`, `NotArithmetic`) or `!label` there.
- An inline alternative group such as `(('NOT' 'IS') | ('IS'? 'NOT'))` in a rule of a priority chain that is followed
  by a guard nonterminal fails to compile ("cannot find symbol variable regular_alt_seq_..."). Write separate rules
  with the same label instead.
- A sequence group with a nullable middle part followed by a literal, such as `(Id Clause* ".")` or
  `(Id Clause? ".")`, fails with a ParseError at offset 0 when the middle part is empty. Write `Id? Clause* "."?` or
  separate rules.
- Sequence groups inside optionals, such as `('UPON' X)?`, work.
- `readTextValueFile` resolves constructors through the environments on the call stack, not from the reified type
  argument, so the calling module must import the modules that define them (`ParseTree`, `util::Maybe` for the
  regression model).
- The type checker (0.43.1-RC2-SNAPSHOT) hangs at full CPU, with no message, on an import of a module that does not
  exist when the name has an escaped package segment (`import lang::cobol85::\syntax::Preprocess;`); without the
  escape it reports "Module not found". When `mvn compile` never finishes, check the
  modules one by one (see Type checking) and look for a wrong import.

## Tests

Run the tests in the REPL with `:test lang::cobol85::\test::Parse` (one module; `test` is a Rascal keyword, so escape
it) or plain `:test` (all imported modules).

- `lang::cobol85::\test::Parse`: `cobol85ParseNIST` (all NIST examples must parse with 0 errors and 0 ambiguities),
  `reportWriterTest`, `cobol85ParseNistCopybooks`.
- `lang::cobol85::\test::AmbiguityRegressionTest`: `runRegressionTests`.

## Type checking

`mvn compile` type-checks all modules at once. To check single modules (and find one that makes the checker hang), run
the compiled checker with a timeout, with absolute module paths and the Rascal jar itself among the libraries:

```
R="${HOME}/.m2/repository/org/rascalmpl"; J="$R/rascal/<version>/rascal-<version>.jar"
timeout 900 java -Xss120M -Xmx4G -cp "$J" org.rascalmpl.shell.RascalCompile -projectRoot "$PWD" \
  -srcs "$PWD/src/main/rascal" -libs "$R/drambiguity/0.4.0/drambiguity-0.4.0.jar:$J:$R/rascal-lsp/2.23.0/rascal-lsp-2.23.0.jar" \
  -bin <scratch>/bin -generatedSources <scratch>/gen -modules "$PWD/src/main/rascal/lang/cobol85/syntax/Main.rsc" -errorsAsWarnings
```

Take the library versions from `pom.xml`, and use a scratch directory for `-bin` so `target` is left alone. A module
takes from 20 seconds to a few minutes.

## Deliberate open gaps

Leave these alone unless asked.

- COPY statements are not expanded, and COPY REPLACING is not applied. `lang::cobol85::\test::Parse` skips the inputs
  that only parse after expansion:
  - `needsCopyExpansion` (SM101A, SM103A, SM206A): a COPY sits in the middle of an entry or statement, where it has no
    natural position in the grammar.
  - `needsReplace` (SM208A).
  - `incompleteCopyBooks` (K101A, K1P01, ...): copybooks that are not a complete construct on their own.
- The grammar accepts sentences that are not COBOL (see Grammar style). A later checker stage will reject them.
- `lang::cobol85::Preprocess` still builds strings with `+`. Turning these into templates is for later.

## Working rules

- Never edit, move or delete any `*.code-workspace` file, and never delete a directory that holds one (such as
  `src/main/rascal/lang/vscobolii`): VS Code reloads the workspace and kills the Claude session. Tell the user what to
  change instead.
- The project is alpha: commit directly on `main`, one logical change per commit. Do not push unless asked.
