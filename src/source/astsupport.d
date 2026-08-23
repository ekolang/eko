module astsupport;

import std.stdio;
import axiom;
import marschiert, std.file, std.string;

void astSupportRun(string filepath, int mode)
{
    if (exists(filepath))
    {
        auto fileline = readText(filepath).splitLines();
        foreach(li; fileline)
        {
            Tokens[] tokenlist = parser(li);
			//writeln(tokenlist);
			Node[] lexer_result = Lexer(tokenlist);
			//writeln(lexer_result);
            if (mode == 1) writeln(lexer_result);
			interp(lexer_result, 0);
        }
    } else prinPanic(kodes._file_faild, "eko ast-mode");
}

void astSupportLine(string li, int mode)
{

    Tokens[] tokenlist = parser(li);
			//writeln(tokenlist);
	Node[] lexer_result = Lexer(tokenlist);
    if (mode == 1) writeln(lexer_result);
			//writeln(lexer_result);
	interp(lexer_result, 0);
}
