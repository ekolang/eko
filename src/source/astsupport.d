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
            Tokens[] tokenlist = lexer(li);
			//writeln(tokenlist);
			Node[] parser_result = parser(tokenlist);
			//writeln(lexer_result);
            if (mode == 1) writeln(parser_result);
			interp(parser_result, 0);
        }
    } else prinPanic(kodes._file_faild, "eko ast-mode");
}

void astSupportLine(string li, int mode)
{

    Tokens[] tokenlist = lexer(li);
			//writeln(tokenlist);
	Node[] parser_result = parser(tokenlist);
    if (mode == 1) writeln(lexer_result);
			//writeln(lexer_result);
	interp(parser_result, 0);
}
