/*import std.stdio, help, std.file;
import structer, parse, lex, inter, ast;
import std.string;
void main(string[] args)
{
	if (args.length > 1)
	{
		if (args[1] == "-e" || args[1] == "--enter")
		{
			if (exists(args[2]))
			{
				string[] tokena = readText(args[2]).splitLines();
				foreach(line; tokena){
					if (args.length > 3 && args[3] == "--mode:debug"){
						Tokens[] tokenlist = parser(line);
						writeln(tokenlist);
						Node[] lexer_result = Lexer(tokenlist);
						writeln(lexer_result);
						interperter(lexer_result, 1);
					} else {
						Tokens[] tokenlist = parser(line);
					//writeln(tokenlist);
						Node[] lexer_result = Lexer(tokenlist);
					//writeln(lexer_result);
						interperter(lexer_result, 0);
					}
				}
			}
		}
	} else helpmenu();
}*/

module axiom;
import std.stdio, std.file, std.algorithm, std.string, std.conv;
public import structer, parse, lex, ast, tokena, ttoken;
string[string] map_str;
string[string] func_table; 
public void interp(Node[] nodes, int mode)
{
	foreach(io; nodes)
	{
		if (auto key = cast(DefineKeyWord)io)
		{
			if (key.type == "string" && key.oprator == 1)
			{
				map_str[key.name] = key.value.replace("\"", "");
				//writeln(map_str[key.name]);
			} else if (key.type == "int" && key.oprator == 1)
			{
				intmap[key.name] = to!int(key.value);
			} else if (key.type == "float" && key.oprator == 1)
			{
				floatmap[key.name] = to!float(key.value);
			} else if (key.type == "double" && key.oprator == 1)
			{
				doublemap[key.name] = to!double(key.value);
			} else if (key.type == "long" && key.oprator == 1)
			{
				longmap[key.name] = to!long(key.value);
			} else if (key.type == "short" && key.oprator == 1)
			{
				shortmap[key.name] = to!short(key.value);
			} else if (key.type == "char" && key.oprator == 1)
			{
				charmap[key.name] = to!char(key.value);
			}
		} else if (auto key = cast(FuncCall)io)
		{
			if (key.name == "write")
			{
				if (key.arguments.startsWith("\"") && key.arguments.endsWith("\"")){
					auto ja = key.arguments.replace("\\n", "\n");
					write(ja.replace("\"", ""));
				} else {
					if (key.arguments in map_str)
					{
						write(map_str[key.arguments].replace("\\n", "\n"));
					} else {
						if (key.arguments in intmap)
						{
							write(intmap[key.arguments]);
						} else if (key.arguments in charmap)
						{
							write(charmap[key.arguments]);
						} else if (key.arguments in shortmap)
						{
							write(shortmap[key.arguments]);
						} else if (key.arguments in longmap)
						{
							write(longmap[key.arguments]);
						} else if (key.arguments in floatmap)
						{
							write(floatmap[key.arguments]);
						} else if (key.arguments in doublemap)
						{
							write(doublemap[key.arguments]);
						}
					}
				}
			}
		} else if (auto key = cast(DefineKeyWordFunc)io ){
			if (mode == 1) writeln(key);
			if (key.type == "string" && key.oprator == 1)
			{
				if (mode) writeln("Relized as string and = oprator equal statement.");
				if(key.func.name == "getInput")
				{
					if (mode) writeln(key.func.arguments);
					if (key.func.arguments.startsWith("this")){
						if (key.func.arguments == "this.chomp"){
							auto i = readln().chomp;
							map_str[key.name] = i;
						}
					} else if (key.func.arguments == "")
					{
						map_str[key.name] = readln();
					} else if (key.func.arguments.indexOf("-v:") != -1 || key.func.arguments.indexOf("--value:") != -1){
						write(map_str[key.func.arguments].replace("\\n", "\n"));
						map_str[key.name] = readln();
					} else {
						auto p = key.func.arguments.replace("\\n", "\n");
						p = key.func.arguments.replace("\"","");
						write(p);
						map_str[key.name] = readln();
					}
				} else if (key.func.name == "readFile")
				{
					if (exists(key.func.arguments.replace("\"", "")))
					{
						map_str[key.name] = readText(key.func.arguments.replace("\"", ""));
					} else {
						if (key.func.arguments in map_str)
						{
							map_str[key.name] = readText(map_str[key.func.arguments]);
						} else writeln("Axiom: file dosent exists.");
					}
				}
			}
		}
	}
}