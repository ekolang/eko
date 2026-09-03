module pars;
import std.stdio;
import structer, ast;
import lex;
Node[] parser(Tokens[] tokens){
	Node[] result;
	if (tokens[0].type == Token.KeyWord)
	{
		if (tokens[1].type == Token.Type && tokens[3].type == Token.Oprators && tokens[3].valu == "=")
		{
			if (tokens[4].type == Token.Func)
			{
				bool inPa = false;
				string argsr = "";
				string funcnam = "";
				//writeln(tokens[4].valu);
				foreach(char i; tokens[4].valu){
					if (i == '(')
					{
						inPa = true;
						continue;
					} else if (i == ')')
					{
						inPa = false;
						continue;
					} else if (i == ';')
					{
						break;
					} else if (inPa == true)
					{
						argsr ~= i;
						continue;
					} else {
						funcnam ~= i;
						continue;
					}
				}
				result ~= new DefineKeyWordFunc(tokens[0].valu, tokens[1].valu, tokens[2].valu, 1, new FuncCall(funcnam, argsr));
			} else {
				result ~= new DefineKeyWord(tokens[0].valu, tokens[1].valu, tokens[2].valu, 1, tokens[4].valu);
			}
		} else if (tokens[0].type == Token.BrNeedFunc){
			foreach(ol; iao)
			{
				//s
			}
		}
	} else if (tokens[0].type == Token.Func)
		{
			bool inp = false;
			string funname = "";
			string args = "";
			foreach(char c; tokens[0].valu)
			{
				if (c == '(')
				{
					inp = true;
					continue;
				} else if (c == ')')
				{
					inp = false;
					continue;
				} else if (c == ';')
				{
					continue;
				} else if (c == '_')
				{
					continue;
				} else if (inp == false)
				{
					funname ~= c;
				} else if (inp == true)
				{
					args ~= c;
				}
			}

			result ~= new FuncCall(funname, args);
		}

	return result;
}
