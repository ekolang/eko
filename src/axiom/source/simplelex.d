module simplelex;

import std.stdio;
import structer;
import std.regex;
import std.string, tokena;
import std.algorithm;
import ast, pars, lex;

Tokens[] slexer(string lineo)
{
	
	Tokens[] result;
	string[] tk = Tokenlz(lineo);
	bool funcag = false;
	string lastfunc;
	foreach (tok; tk)
	{
        if (funcag){
			iao ~= BlockType(lastfunc, tok.replace("\"", ""));
			result ~= Tokens(Token.Func, lastfunc);
			lastfunc = "";
			funcag = false;
			continue;
		} else if (tok == "generate" || tok == "gen")
		{
			result ~= Tokens(Token.KeyWord, tok);
		} else if (tok == "string" || tok == "int" || tok == "float" || tok == "long" || tok == "short" || tok == "double")
		{
			result ~= Tokens(Token.Type, tok);
		} else if (tok.startsWith("@"))
		{
			result ~= Tokens(Token.Name, tok);
		} else if (tok == "=" || tok == "==" || tok == ">" || tok == "<")
		{
			result ~= Tokens(Token.Oprators, tok);
		} else if (tok.startsWith("_"))
		{
			lastfunc = tok;
			funcag = true;
			continue;
		} else if(tok.startsWith("\"") && tok.endsWith("\"")){
			result ~= Tokens(Token.Value, tok.replace("\"", ""));
		} else {
            result ~= Tokens(Token.Value, tok);
        }
		
	}
	
	return result;
}
