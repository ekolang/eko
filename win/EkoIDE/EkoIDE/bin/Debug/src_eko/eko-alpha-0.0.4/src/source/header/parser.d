module header.parser;

import std.stdio, std.string, std.algorithm, std.regex, header.ast, infss, token_string, std.algorithm, std.conv;

string[] header_type_support = ["HeadConfig"];
int generatesaw = 0;
int headersaw = 0;
int bropen = 0;
int brclose = 0;
string[] linesaver;
void par9ser(Tokan[] line, string strline, ref int kjka)
{
    //writeln("strline: " ~ strline);
    //writeln("linesaver: " ~ linesaver);
    //string[] abc = line.splitLines();
    Tokan check_token = Tokan(TokanType.Br2, "}");
    if (canFind(line, check_token)) brclose = 1;
    foreach(jk; line)
    {
        if (jk.value == "generate" || jk.value == "gen")
        {
            generatesaw = 1;
            continue;
        } else if (jk.value == "header")
        {
            headersaw = 1;
            continue;
        } else if (jk.value == "{")
        {
            if (generatesaw == 1 && headersaw == 1)
            {
                bropen = 1;
                continue;
            }
        }
    }
    //writeln("bropen=", bropen,
       // " generatesaw=", generatesaw,
      //  " headersaw=", headersaw);
    if (bropen == 1)
    {
        auto stripedline = strip(strline);
        if (stripedline != "}"){
            if (stripedline == "{"){ /*noting*/ }
            else linesaver ~= stripedline;
        } else {
            
            foreach (ola; linesaver)
            {
                string[] la = tkstring(ola, "normal");
                Tokan[] tklist;
                foreach(oo; la)
                {
                    bool ol;
                    foreach (p; header_type_support)
                    {
                        if (oo == p)
                        {
                            tklist ~= Tokan(TokanType.Keyword, oo);
                            ol = true;
                            break;
                        }
                    }
                    if (ol) continue;
                    if (oo.startsWith("Graphic"))
                    {
                        tklist ~= Tokan(TokanType.Name, oo);
                    } else {
                        tklist ~= Tokan(TokanType.Value, oo);
                    } 
                }
                //writeln(tklist);
                //writeln("++++++++++++++++++");
                //writeln(linesaver);
                if (tklist.length > 1 && tklist[0].value == "HeadConfig" && tklist.length > 1)
                {
                    //writeln(tklist);
                    if (tklist[1].value == "GraphicEnable" && tklist[2].value == "=")
                    {
                        auto node1 = new HeaderConfigManager(to!int(tklist[3].value), tklist[1].value);
                        node1.execute();
                    }
                } else {
                    continue;
                }
            }
            kjka = 0;
        }
    }
}