module pars;
import std.stdio, std.range;
import structer, ast;
import lex, axiom, std.string;
import std.ascii : isDigit;
import std.conv;

Node[] parser(Tokens[] tokens){
	Node[] result;
	writeln(iao);
	if (tokens.length > 0 && tokens[0].type == Token.KeyWord && tokens[1].type == Token.Type && tokens[2].type == Token.Name)
	{
		if (tokens[3].type == Token.Func){
			foreach(lk; iao)
			{
				if (lk.funcname == tokens[3].valu)
				{
					result ~= new DefineKeyWordFunc("gen", tokens[1].valu, tokens[2].valu, new FuncCall(lk.funcname, lk.argumnets));
					iao.popFront();
					break;
				} else continue;
			}
		} else result ~= new DefineKeyWord("gen", tokens[1].valu, tokens[2].valu, tokens[3].valu);
	} else if(tokens.length > 0 && tokens[0].type == Token.Func){
		foreach(op; iao)
		{
			if (op.funcname == tokens[0].valu)
			{
				result ~= new FuncCall(op.funcname, op.argumnets);
				iao.popFront();
				break;
			}
		}
	} else if (tokens.length > 0 && tokens[0].type == Token.BrNeedFunc)
	{
		bool resulta;
		foreach (bk; ifs)
		{
			if (bk.pical == tokens[0].valu)
			{
				if (bk.args[0].type == Token.Value && bk.args[1].type == Token.Oprators && bk.args[2].type == Token.Value)
				{
					try {
						int left = to!int(bk.args[0].valu);
						int right = to!int(bk.args[1].valu);
						if (bk.args[1].valu == "==")
						{
							if (left == right) resulta = true;
							else resulta = false;
						} else if (bk.args[1].valu == ">")
						{
							if (left > right) resulta = true;
							else resulta = false;
						} else if (bk.args[1].valu == "<")
						{
							if (left < right) resulta = true;
							else resulta = false;
						}
					} catch(Exception e){
						//nting
					}
				}
				if (resulta)
				{
					result ~= new IfState(bk.bod);
				}
			}
		}
	}
	return result;
}