import std.stdio, marschiert, std.regex, std.string, infss, std.conv;

interface Node
{
    void execute();
}
int count_to_find_end;
class ProgramNode: Node {
    Node[] codee;
    this(Node[] codee)
    {
        this.codee = codee;
    }
    override void execute()
    {
        foreach (far; codee)
        {
            far.execute();
        }
    }
}
class FucntionDefined: Node {
    string name;
    string[] para_names;
    string[] para_type;
    Node[] code;
    this(string name, string[] para_names, string[] para_type, Node[] code)
    {
        this.name = name;
        this.para_names = para_names;
        this.para_type = para_type;
        this.code = code;
    }
    override void execute()
    {
        foreach (part_of_code; code)
        {
            part_of_code.execute();
        }
    }
}
class PrintDefined: Node {
    string value;
    this(string value)
    {
        this.value = value;
    }
    override void execute()
    {
        write(value);
    }
}
struct Func
{
    string name;
    string[] code;
    string[] arg;
}
string[] funcvaluesave;
string funcname;
string[string] ka;
string[] args;
Func[] globalf;
int argsmode = 0;
void handle_(Tokan[] tkl, string mode, string li)
{
    {
        //writeln(tkl);
    }
    //check if is it func or not
    if (tkl.length > 1 && (tkl[0].value == "generate" || tkl[0].value == "gen"))
    {
        // developer wants to define something.
        // if it dosent be main, or int or a keyword, + header and BOX its count as function
        if (tkl[1].token == TokanType.Value && tkl[1].value.indexOf("\"") == -1)
        {
            auto op = regex(`\(([^)]+)\)`);
            auto lap = match(tkl[1].value, op);
            auto lapaa = tkl[1].value.replace("(", "");
            lapaa = lapaa.replace(")", "");
            funcname = lapaa.replace(lap.captures[1], "");
            ka[tkl[1].value ~ ";"] ~= lapaa;
            if (lap.empty && (tkl[1].value.endsWith(")") && tkl[1].value.startsWith(lapaa ~ "("))){
                //define without parameters.
                if (tkl[2].value == "{"){
                    count_to_find_end = 1;
                }
                if (mode == "debug") {
                    writeln("l7U:" ~ to!string(globalf));
                    writeln("l8U:" ~ funcname);
                    writeln("I9U:" ~ funcvaluesave);
                }
            } else if (lap.empty && tkl[1].value.indexOf("(") == -1 && tkl[1].value.indexOf(")") != -1){
                prinPanic(kodes._syntex_faild, "function define progress faild.");
            } else if(!lap.empty){
                foreach (opl; lap)
                {
                    args ~= to!string(opl.captures);
                }
                argsmode = 1;
                if (tkl[2].value == "{"){
                    count_to_find_end = 1;
                }
            } else {
                prinPanic(kodes._syntex_faild, "function define progress faild.");
            }
        }




        if(count_to_find_end == 1){
            if (tkl[to!int(tkl.length) - 1].value == "}")
            {
                if (argsmode == 1){
                    globalf ~= Func(funcname, funcvaluesave, args);
                funcvaluesave = null;
                if (mode == "debug")writeln("i90P:" ~ to!string(globalf));
                count_to_find_end = 0;
                } else {
                globalf ~= Func(funcname, funcvaluesave, [""]);
                funcvaluesave = null;
                if (mode == "debug")writeln("i90P:" ~ to!string(globalf));
                count_to_find_end = 0;
                }
            } else {
                if (tkl[0].value == "generate" || tkl[0].value == "gen") funcvaluesave ~= li;
            }
        }
    }
}


void asthandler(Node[] pack)
{
    foreach (kks; pack)
    {
        kks.execute();
    }
}