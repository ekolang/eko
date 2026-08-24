/*

module asmiva.parser;

import std.stdio, std.string, std.algorithm, std.regex, box_p.header.ast, infss, token_string, std.algorithm, std.conv;

int boxsaw = 0;
int bropen1 = 0;
int brclose1 = 0;
string[] linesaver1;
void sbox_nparser(string strline, ref int kjka)
{
    string[] op = tkstring(strline, "normal");   
    foreach(jk; op)
    {
        if (jk == "#BOX")
        {
            boxsaw = 1;
            continue;
        } else if (jk == "{")
        {
            if (boxsaw == 1)
            {
                bropen1 = 1;
                continue;
            }
        }
    }
    //writeln("bropen=", bropen,
       // " generatesaw=", generatesaw,
      //  " headersaw=", headersaw);
    if (bropen1 == 1)
    {
        auto stripedline = strip(strline);
        if (stripedline != "}"){
            if (stripedline == "{"){  }
            else linesaver1 ~= stripedline;
        } else {
            
            foreach (ola; linesaver1)
            {
                auto la = new BoxManager(ola);
                la.execute();
            }
            kjka = 0;
            bropen1 = 0;
            brclose1 = 0;
            linesaver1.length = 0;
        }
    }
}
*/