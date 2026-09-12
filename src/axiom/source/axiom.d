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
public import structer, pars, lex, ast, tokena;
import cbased;
import arsd.minigui, safeargs, core.thread, core.time;
//string[string] map_str;
string[string] func_table; 
MainWindow[string] gwin;
Button[string] gbtn;
TextLabel[string] glabel;
import error;
bool tick = false;
bool broke = false;
int time;
//import std.datetime.stopwatch;
//auto sw = StopWatch(AutoStart.yes);
public void interp(Node[] nodes, int mode)
{
	    //writeln("[INTERP] nodes = ", nodes.length);
	foreach(io; nodes)
	{
		if (auto key = cast(DefineKeyWord)io)
		{
			if (key.type == "string")
			{
				string[] a1 = Tokenlz(key.value);
				string[] a2 = safe_args(map_str, a1);
				foreach(op; a2)
				{
					if (key.name in map_str) map_str[key.name] = map_str[key.name] ~ op.replace("\"", "");
					else map_str[key.name] = op.replace("\"", "");
				}
				//map_str[key.name] = key.value.replace("\"", "");
				//writeln(map_str[key.name]);
				//writeln(key.name);
			} else if (key.type == "int")
			{
				intmap[key.name] = to!int(key.value);
			} else if (key.type == "float")
			{
				floatmap[key.name] = to!float(key.value);
				//writeln(floatmap);
			} else if (key.type == "double")
			{
				doublemap[key.name] = to!double(key.value);
			} else if (key.type == "long")
			{
				longmap[key.name] = to!long(key.value);
			} else if (key.type == "short")
			{
				shortmap[key.name] = to!short(key.value);
			} else if (key.type == "char")
			{
				charmap[key.name] = to!char(key.value);
			}
		} else if (auto key = cast(FuncCall)io)
		{
			if (key.name == "_write")
			{
				string[] lp = key.arguments.split("+");
				//writeln(key.arguments);
				foreach(lp1p; lp){
					string lp1 = lp1p.strip();
				if ((!lp1.startsWith("@"))){ // if it was text : _write "Hello world!"
					auto ja = lp1.replace("\\n", "\n");
					write(ja.replace("\"", ""));
					//writeln("\nWRITE CALLED: ", key.name, " ARG = [", key.arguments, "]");
				} else {
					if (lp1 in map_str)
					{
						write(map_str[lp1].replace("\\n", "\n"));
					} else {
						if (lp1 in intmap)
						{
							write(intmap[lp1]);
						} else if (lp1 in charmap)
						{
							write(charmap[lp1]);
						} else if (lp1 in shortmap)
						{
							write(shortmap[lp1]);
						} else if (lp1 in longmap)
						{
							write(longmap[lp1]);
						} else if (lp1 in floatmap)
						{
							write(floatmap[lp1]);
						} else if (lp1 in doublemap)
						{
							write(doublemap[lp1]);
						} else {
							_error("\"\033[32m\033[1m" ~ lp1.replace("@", "") ~ "\033[0m\"" ~ " does not exist in any of the data types or is undefined.");
						}
					}
				}
			}
			} else if (key.name == "_mainWindow")
			{
				string[] argsa1 = Tokenlz(key.arguments);
				//do it all time for safty
				string[] argsa = safe_args(map_str, argsa1);
				//writeln(argsa);
				
				if (argsa.length >= 2){
					gwin[argsa[0].replace("\"", "")] = new MainWindow(argsa[1].replace("\"", ""));
				}
			} else if (key.name == "_button")
			{
				// it have 2 arguments we must call tokena to get them
				//writeln(key.arguments);
				string[] argsa1 = Tokenlz(key.arguments);
				//do it all time for safty
				string[] argsa = safe_args(map_str, argsa1);
				//writeln(argsa);
				
				if (argsa.length >= 2) gbtn[argsa[0]] = new Button(argsa[0].replace("\"", ""), gwin[argsa[1].replace("\"", "")]);
				else _error("`_button` requires 2 arguments.");
			} else if (key.name == "_loopWindow")
			{
				if (key.arguments.replace("\"", "") in gwin)
				{
					gwin[key.arguments.replace("\"", "")].loop();
				} else _error("`_loopWindow` The entered variable name for window does not exist.");
			} else if (key.name == "_debugPrintAllString")
			{
				if (!(key.arguments == "NULL"))
				{
					_error("The input for this function\033[1m\033[34m _debugPrintAllString \033[0m must be null (empty).");
				}
			} else if (key.name == "_label")
			{
				string[] argsa1 = Tokenlz(key.arguments);
				//do it all time for safty
				string[] argsa = safe_args(map_str, argsa1);
				//writeln(argsa);
				if (argsa.length >= 3) {
					//writeln(argsa);
					if (!(argsa[1].startsWith("\"") && argsa[1].endsWith("\""))) _error("`_label: " ~ map_str["@BOLD"] ~ "Third argument`," ~ map_str["@RESET"] ~" The input must be a string.");
					else argsa[1] = argsa[1].replace("\"", "");
					if (argsa[1] == "center"){
						glabel[argsa[0]] = new TextLabel(argsa[0].replace("\"", ""), TextAlignment.Center, gwin[argsa[2].replace("\"", "")]);
					} else if (argsa[1] == "left")
					{
						glabel[argsa[0]] = new TextLabel(argsa[0].replace("\"", ""), TextAlignment.Left, gwin[argsa[2].replace("\"", "")]);
					} else if (argsa[1] == "right")
					{
						glabel[argsa[0]] = new TextLabel(argsa[0].replace("\"", ""), TextAlignment.Right, gwin[argsa[2].replace("\"", "")]);
					} else {
						_error("`_label`: " ~ argsa[1] ~" The specified text position does not exist.");
					}
				}
			} else if (key.name == "_abort")
			{
				if (key.arguments != "NULL")
				{
					_error("The input for this function\033[1m\033[34m _debugPrintAllString \033[0m must be null (empty).");
				} else _abort();
			} else if (key.name == "_break")
			{
				if (key.arguments != "NULL")
				{
					_error("The input for this function\033[1m\033[34m _debugPrintAllString \033[0m must be null (empty).");
				} else broke = true;
			} else if (key.name == "_time")
			{
				try {
					time = to!int(key.arguments);
					continue;
				} catch(Exception e)
				{
					_error("Just put int for `_time`");
				}
			}
		} else if (auto key = cast(DefineKeyWordFunc)io ){
			//writeln(key);
			
			if (key.type == "string")
			{
				if (mode) writeln("Relized as string and = oprator equal statement.");
				if(key.func.name == "_getInput")
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
					} else if (key.func.arguments.indexOf("@") != -1){
						write(map_str[key.func.arguments].replace("\\n", "\n"));
						map_str[key.name] = readln();
					} else {
						auto p = key.func.arguments.replace("\\n", "\n");
						p = key.func.arguments.replace("\"","");
						write(p);
						map_str[key.name] = readln();
					}
				} else if (key.func.name == "_readFile")
				{
					//writeln(key.func.arguments);
					if (exists(key.func.arguments.replace("\"", "")))
					{
						map_str[key.name] = readText(key.func.arguments.replace("\"", ""));
					} else {
						if (key.func.arguments in map_str)
						{
							map_str[key.name] = readText(map_str[key.func.arguments]);
						} else _error("File \033[1m\033[34m" ~ key.func.arguments ~ "\033[0m Not exists.");
					}
				}
			} else if (key.type == "double"){
				//writeln(key.func.name);
				if (key.func.name == "_acos")
				{
					//writeln(_acos(0.5));
					double ka = to!double(key.func.arguments);
					doublemap[key.name] = _acos(ka);
					//writeln(key.name);
					//writeln(doublemap[key.name]);
					if (doublemap[key.name] == 0.0)
					{
						writeln("Core fault: `_acos` value must satisfy the following rules [value =< 1, value >= -1]");
						_abort();
					}
				} else if(key.func.name == "_asin"){
					double ka = to!double(key.func.arguments);
					doublemap[key.name] = _asin(ka);
					if (doublemap[key.name] == 0.0)
					{
						writeln("Core fault: `_asin` value must satisfy the following rules [value =< 1, value >= -1]");
						_abort();
					}
				} 
			}
		} else if (auto key = cast(IfState)io)
		{
			interp(key.bodya, 0);
		} else if (auto key = cast(DefineDelegate)io)
		{
			//writeln("DELEGATE FOUND");
    		//writeln("EVENT: ", key.event_name);
    		//writeln("BODY: ", key._body);
			if (key.event_name == "tick")
			{

				while(!broke){
					
					Thread.sleep(dur!"msecs"(time));
					interp(key._body, 0);
					stdout.flush();
					tick = false;
				}
			} else _error("Such an event is not defined.");
		}
	}
}
