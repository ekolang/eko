module pars;
import std.stdio, std.range;
import structer, ast;
import lex, axiom, std.string;
Node[] parser(Tokens[] tokens){
	Node[] result;
	writeln(iao);
	if (tokens[0].type == Token.KeyWord && tokens[1].type == Token.Type && tokens[2].type == Token.Name)
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
	} else if(tokens[0].type == Token.Func){
		foreach(op; iao)
		{
			if (op.funcname == tokens[0].valu)
			{
				result ~= new FuncCall(op.funcname, op.argumnets);
				iao.popFront();
				break;
			}
		}
	}
	return result;
}