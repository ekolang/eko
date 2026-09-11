module simplelex;

import std.stdio;
import structer;
import std.regex;
import std.string, tokena;
import std.algorithm;
import ast, pars, lex;
bool funcaag = false;
string lastfunca;
import safeargs;
Tokens[] slexer(string lineo)
{
	
	Tokens[] result;
	string[] tk = Tokenlz(lineo);
	
	foreach (tok; tk)
	{
		{
			//writeln(tok);
			//writeln("slexer - funcaag: ", funcaag);
		}
        if (funcaag && !(tok == "")){
			iao ~= BlockType(lastfunca, tok.replace("\"", ""));
			result ~= Tokens(Token.Func, lastfunca);
			lastfunca = "";
			funcaag = false;
			continue;
		} else if (tok == "generate" || tok == "gen")
		{
			result ~= Tokens(Token.KeyWord, tok);
		} else if (tok == "string" || tok == "int" || tok == "float" || tok == "long" || tok == "short" || tok == "double")
		{
			result ~= Tokens(Token.Type, tok);
		} else if (tok.startsWith("@"))
		{
			result ~= Tokens(Token.Value, tok);
		} else if (tok == "=" || tok == "==" || tok == ">" || tok == "<")
		{
			result ~= Tokens(Token.Oprators, tok);
		} else if (tok.startsWith("_"))
		{
			lastfunca = tok;
			funcaag = true;
			continue;
		} else if(tok.startsWith("\"") && tok.endsWith("\"")){
			result ~= Tokens(Token.Value, tok.replace("\"", ""));
		} else if(tok == ""){
			continue;
		} else {
            result ~= Tokens(Token.Value, tok);
        }
		
	}
	
	return result;
}
