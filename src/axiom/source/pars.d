module pars;
import std.stdio, std.range;
import structer, ast;
import lex, axiom, std.string;
import std.ascii : isDigit;
import std.conv, error, safeargs;

Node[] parser(Tokens[] tokens){
	Node[] result;
	//writeln(iao);
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
				//writeln("op:" ,op.argumnets);
				//writeln("[PARSER] iao BEFORE = ", iao.length);
				iao.popFront();
				//writeln("[PARSER] iao after = ", iao.length);
				break;
			}
		}
	} else if (tokens.length > 0 && tokens[0].type == Token.BrNeedFunc)
	{
		bool resulta;
		//writeln(ifs);
		foreach (bk; ifs)
		{
			foreach(k, l; bk.args)
			{
				string patrik = safe_args_string(map_str, l.valu);
				bk.args[k].valu = patrik.strip();
				continue;
			}
			//writeln("me: ", bk);
			if (bk.pical == tokens[0].valu)
			{
				if (bk.args.length >= 3 && bk.args[0].type == Token.Value && bk.args[1].type == Token.Oprators && bk.args[2].type == Token.Value)
				{
					try {
						int left = to!int(bk.args[0].valu);
						int right = to!int(bk.args[2].valu);
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
						string left = bk.args[0].valu.replace("\"", "");
						string right = bk.args[2].valu.replace("\"", "");
						//writeln("L: " ~ left);
						//writeln("R:" ~ right);
						if (bk.args[1].valu == "==")
						{
							if (left == right) resulta = true;
							else resulta = false;
						} else {
							_error("Can't use `" ~ bk.args[1].valu ~ "` for this types. (string)");
						}
					}
				}
				//writeln(resulta);
				if (resulta)
				{
					    //writeln("[PARSER] added IfState, body nodes = ", bk.bod.length);
					result ~= new IfState(bk.bod);
					//writeln(bk.bod);
				}
			}
		}
	}
	//writeln(ifs);
	return result;
}
