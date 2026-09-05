module lex;
import std.stdio;
import structer;
import std.regex;
import std.string, tokena;
import std.algorithm;
import ast, pars;
public string[] funclist = ["getInput", "readFile", "write"];
Blocktype[] iao;

bool insidef = false;
Tokens[] lexer(string lineo)
{
	Node[] lop;
	Node[] bodyof;
	bool getarg = false;
	Tokens[] result;
	string[] tk = Tokenlz(lineo);
	string res;
	bool inf = false;
	string funcname;
	foreach (tok; tk)
	{
		if (tok == "generate" || tok == "gen")
		{
			result ~= Tokens(Token.KeyWord, tok);
		} else if (tok == "string" || tok == "int" || tok == "float" || tok == "long" || tok == "short" || tok == "double")
		{
			result ~= Tokens(Token.Type, tok);
		} else if (tok.startsWith("--value") || tok.startsWith("-v"))
		{
			result ~= Tokens(Token.Name, tok);
		} else if (tok == "=" || tok == "==" || tok == ">" || tok == "<")
		{
			result ~= Tokens(Token.Oprators, tok);
		} else if (tok in funclist){
			inf = true;
			funcname = tok;
			continue;
		} else if (inf){
			result ~= Tokens(Token.Func, funcname ~ tok);
			funcname = "";
			inf = false;
			continue;
		} else if (tok == "if"){
			getarg = true;
			continue;
		} else if (getarg == true && tok.startsWith("(") && tok.endsWith(")")){
			// i must start from here
		} else {
			bool inP = false;
			string funcna = "";
			foreach (char i; tok)
			{
				if (i == '(')
				{
					inP = true;
					continue;
				} else if (i == ')') {
					inP = false;
					break;
				} else if (inP == true){
					continue;
				} else {	
					funcna ~= i;
				}
			}
			//writeln("====:" ~ funcna);
			bool inforeach = false;
			foreach (value; inString_Func_support)
			{
				if (funcna == value)
				{
					inforeach = true;
					break;
				}
			}
			if (inforeach)
			{
				result ~= Tokens(Token.Func, tok);
			} else result ~= Tokens(Token.Value, tok);
		}
		if (insidef && tok != "end;")
		{
			bodyof ~= parser(result);
			continue;
		} else {
			if (tok == "end;")
			{
				insidef = false;
				iao ~= Blocktype(lop, bodyof);
				bodyof = [];
				lop = [];
				continue;
			}
		}
	}
	
	return result;
}
