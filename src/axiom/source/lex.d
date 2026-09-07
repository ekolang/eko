module lex;
import std.stdio;
import structer;
import std.regex;
import std.string, tokena;
import std.algorithm;
import ast, pars;
public string[] funclist = ["getInput", "readFile", "write"];
BlockType[] iao;
BlockIf[] ifs;
bool insidef = false;

Tokens[] lexer(string lineo)
{
	
	Tokens[] result;
	string[] tk = Tokenlz(lineo);
	bool funcag = false;
	string lastfunc;
	bool if_ = false;
	bool kl = false;
	Tokens[] arguments;
	string ag;
	Node[] body_of_if;
	foreach (tok; tk)
	{
		{
			writeln(kl);
			writeln(if_);
			writeln(ag);
			writeln(body_of_if);
		}
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
			writeln("BEFORE:");
    writeln("if_ = ", if_);
    writeln("kl = ", kl);
    writeln("tok = ", tok);

    arguments ~= lexer(tok);
    ag = tok;
    if_ = false;
    kl = true;

    writeln("AFTER:");
    writeln("if_ = ", if_);
    writeln("kl = ", kl);
    writeln("ag = ", ag);

    continue;
		} else if (kl){
			if (tok == "end")
			{
				ifs ~= BlockIf(ag,arguments, body_of_if);
				arguments = [];
				kl = false;
				body_of_if = [];
				result ~= Tokens(Token.BrNeedFunc, ag);
				ag = "";
				continue;
			} else {
				writeln(body_of_if);
				writeln(tok);
				writeln(lexer(tok));
				if(tok == "") continue;
				body_of_if ~= parser(lexer(tok));
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
		}
		
	}
	writeln(result);
	writeln(tk);
	return result;
}
