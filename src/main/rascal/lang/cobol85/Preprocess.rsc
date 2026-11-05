module lang::cobol85::Preprocess

import String;
import List;
import IO;

@synopsis{COBOL pre-processing involves (mostly) replacing the margins with a control character.}
str preprocess(str src) {
    list[str] lines = split("\n", src);
    // the sequence area (columns 1-6) and the identification area (from column 73) are filled with the margin
    // character, in place, so that every line keeps its length and all offsets stay the same, also for lines that are
    // shorter or longer than 80. The grammar reads the margins as layout and highlights them as comments.
    lines = [margin(line[..6]) + line[6..72] + margin(line[72..]) | str line <- lines];

    // Debugging lines (`D` in the indicator column) are code when the program is compiled `WITH DEBUGGING MODE`
    // (a clause of SOURCE-COMPUTER), and comment lines otherwise.
    str debugIndicator = /DEBUGGING\s+MODE/i := src ? " " : "*";
    lines = [indicator(line) in { "D", "d" } ? line[0..6] + debugIndicator + line[7..] : line | str line <- lines];
    
    // A continuation line (`-` in the indicator column) that does not continue a literal continues the last word
    // of the previous code line, as in `PIC S9(` followed by `-  6)V9(6).`. We glue its text to the end of that
    // line and blank the continuation line, so the total length, and with it all offsets after it, stay the same.
    // Continued literals (the continuation line starts with a quote) are left to the grammar (`NonnumericPart`),
    // except when the continued line has a quote in column 72: that quote is part of the literal, as in `"...8J"`
    // continued by `""9K..."`, which reads `"...8J""9K..."`, so we glue the text after the continuation quote.
    int last = -1;
    // the previous code line
    for (int i <- index(lines)) {
        str line = lines[i];
        str ind = indicator(line);
        // the code area, without the margin
        str body = line[7..72];

        if (ind in { "*", "/" } || trim(body) == "") {
            continue;
        }
        str glued = "";
        if (ind == "-", last >= 0, /^\s*<text:[^\"\'\s].*?>\s*$/ := body) {
            glued = rtrim(lines[last]) + text;
        }
        else if (ind == "-", last >= 0, size(lines[last]) > 71, lines[last][71] in { "\"", "\'" }, /^\s*[\"\']<text:.*?>\s*$/ := line[7..72]) {
            glued = lines[last][..72] + text;
        }
        else {
            last = i;
            continue;
        }
        
        lines[i] = left("", size(lines[last]) + size(line) - size(glued));
        lines[last] = glued;
    }
    
    return intercalate("\n", lines) + "\n";
}

// without trailing spaces and margin characters
private str rtrim(str s) = /^<body:.*?>[\s\uE000]*$/ := s ? body : s;

// a private use character, so the margins never mix with spaces or code: this keeps the margin layout unambiguous
private str marginChar = "\uE000";

private str margin(str s) = left("", size(s), marginChar);

// column 7; a line that is too short to have one has a blank indicator
private str indicator(str line) = size(line) > 6 ? line[6] : " ";
