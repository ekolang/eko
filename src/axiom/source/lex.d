module lex;
import std.stdio;
import structer;
import std.regex;
import std.string, tokena;
import std.algorithm;
import ast, pars, simplelex;
public string[] funclist = ["getInput", "readFile", "write"];
BlockType[] iao;
BlockIf[] ifs;
bool kl = false;
string ag;
Node[] body_of_if;
Tokens[] arguments;
Tokens[] lexer(string lineo)
{
	
	Tokens[] result;
	string[] tk = Tokenlz(lineo);
	bool funcag = false;
	string lastfunc;
	bool if_ = false;
	//bool kl;
	bool ini = true;
	foreach (tok; tk)
	{
		/*{
			writeln(kl);
			writeln(if_);
			writeln("AG: " ~ ag);
			writeln(body_of_if);
		}*/
		if (ag.indexOf(tok) != -1){
			continue;
		}
		if (funcag){
			iao ~= BlockType(lastfunc, tok.replace("\"", ""));
			result ~= Tokens(Token.Func, lastfunc);
			lastfunc = "";
			funcag = false;
			continue;
		} else if (if_){
            arguments ~= slexer(tok);
            ag = tok;
			//writeln("TOK = " ~ tok);
            if_ = false;
            kl = true;
			continue;
		} else if (kl && ini){
			if (tok == "end")
			{
				ifs ~= BlockIf(ag, arguments, body_of_if);
				arguments = [];
				kl = false;
				body_of_if = [];
				result ~= Tokens(Token.BrNeedFunc, ag);
				ag = "";
				ini = false;
				continue;
			} else {
				ini = false;
				if(tok == "") continue;
				body_of_if ~= parser(slexer(lineo));
				continue;
			}
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
		} else if(tok == "if"){
			if_ = true;
			continue;
		} else {
			result ~= Tokens(Token.Value, tok);
		}
		
	}
	//writeln(result);
	//writeln(tk);
	return result;
}
