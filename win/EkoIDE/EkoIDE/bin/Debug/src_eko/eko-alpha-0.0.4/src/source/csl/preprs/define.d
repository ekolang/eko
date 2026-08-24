module csl.preprs.define;

import std.stdio, std.string, std.algorithm, std.regex, csl.preprs._sbox, box_p.header.parser;

int counter_of_box = 0;
string define_(string a, string mode)
{
        string reso;
        string[int] va1;
        string[int] va2;
        int i = 0;
        foreach (lk; a.splitLines())
        {
            if (lk.indexOf("#define") != -1)
            {
                auto kk = regex(`\#define (\S+) (\S+)`);
                auto mrhb = match(lk, kk);
                if (!mrhb.empty)
                {
                    va1[i] = mrhb.captures[1];
                    va2[i] = mrhb.captures[2];
                    i++;
                    continue;
                }
            } else if(lk.startsWith("#BOX")){
                counter_of_box = 1;
                if (lk.strip().indexOf("{") != -1)
                {
                    sbox_nparser(lk, counter_of_box);
                } else {
                    sbox(lk, "normal", 1);
                }
                continue;
            } else {
                reso = reso ~ "\n" ~ lk;
            }
        }
        if (mode == "debug"){
        writeln(va1);
        writeln(va2);
        writeln(i);
        }
        int o = 1;
        int k = 0;
        foreach(al; va1)
        {   
            if (k == i) break;
            if (mode == "debug"){
            writeln(k);
            }
            reso = reso.replace(al, va2[k]);
            if (mode == "debug"){
            writeln(reso);        
            }
            k++;
        } 
        return reso;
}