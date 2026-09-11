module lex;
import std.stdio;
import structer;
import std.regex;
import std.string, tokena;
import std.algorithm;
import ast, pars, simplelex, safeargs;
public string[] funclist = ["getInput", "readFile", "write"];
BlockType[] iao;
BlockIf[] ifs;
bool kl = false;
string ag;
Node[] body_of_if;
Tokens[] arguments;
int ip = 0;
	bool df = false;
	bool funcag = false;
	string lastfunc;
	bool if_ = false;
	//bool kl;
	bool ini = true;
Tokens[] lexer(string lineo)
{
	
	Tokens[] result;
	string[] tk = Tokenlz(lineo);
	//writeln(tk);
	
	
	foreach (tok; tk)
	{
		/*{
			writeln(kl);
			writeln(if_);
			writeln("AG: " ~ ag);
			writeln(body_of_if);
		}*/
		/*{
			writeln(ag);
			writeln(df);
			writeln(ip);
			writeln(arguments.length);
			writeln("T: ", funcag);
			writeln("IL: " ~ tok);
		}*/
		tok = tok.strip();
		if (ag.indexOf(tok) != -1 && df && ip != arguments.length){
			ip = ip + 1;
			//writeln(tok);
			continue;
		} else {
			df = false;
			ip = 0;
		}
		if (funcag && !(tok == "")){
			iao ~= BlockType(lastfunc, tok);
			result ~= Tokens(Token.Func, lastfunc);
			lastfunc = "";
			funcag = false;
			continue;
		} else if (if_){
            arguments ~= slexer(tok);
            ag = tok;
			df = true;
			//writeln("TOK = " ~ tok);
            if_ = false;
            kl = true;
			continue;
		} else if (kl){
			if (tok == "end")
			{
				ifs ~= BlockIf(ag, arguments, body_of_if);
				//writeln("Devil and angel in my shoulder: ", ifs);
				arguments = [];
				kl = false;
				body_of_if = [];
				result ~= Tokens(Token.BrNeedFunc, ag);
				ag = "";
				ini = false;
				continue;
			} else {
				if(tok == "") continue;
				//writeln("[LEX] PARSING IF BODY: [", lineo, "]");
				if (ini){
					body_of_if ~= parser(slexer(lineo));
					ini = false;
					continue;
				} else {
					ini = true;
					continue;
				}
				//writeln("body of if : ", body_of_if);
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
		} else if(tok.startsWith("{") && tok.endsWith("}")){
			result ~= Tokens(Token.BrNeedFunc, tok);
		} else if (tok == "") {
			continue;
		} else {
			result ~= Tokens(Token.Value, tok);
		}
		
	}
	//writeln(result);
	//writeln(tk);
	//writeln(iao);
	return result;
}
