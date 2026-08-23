module parse;
import std.stdio;
import structer;
import std.regex;
import std.string, tokena;
import std.algorithm;
public string[] inString_Func_support = ["getInput", "readFile"];
Tokens[] parser(string lineo)
{
	Tokens[] result;
	string[] tk = Tokenlz(lineo);
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
		} else if (tok == "=")
		{
			result ~= Tokens(Token.Oprators, tok);
		} else if (tok.startsWith("_") && tok.endsWith(");"))
		{
			result ~= Tokens(Token.Func, tok);
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
	}
	return result;
}