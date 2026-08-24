module cshort;

import  std.stdio, infss, std.string, std.ascii, std.algorithm: all;
import  std.conv;


string lastinput = "";
int lastinpuat  = 0;
void shortmode_run(Tokan[] aline)
{
    foreach(line; aline){
        //writeln(line.value);
    int ssp;
    if (line.value == "~")
    {
        //noting.
    } else if (line.value == "?")
    {
        write("\n\033[32m>\033[0m ");
        auto kala = readln().strip();
        int[] iu;
        foreach(k, la; kala)
        {
            if (isDigit(cast(char)la))
            {
                iu ~= 1;
            } else {
                iu ~= 0;
            }
        }
        auto jaa = iu.all!"a == 1";
        //debug
        //writeln(jaa);
        if(jaa == true)
        {
            ssp = to!int(kala);
            lastinpuat = ssp;
            int_s["l"] = lastinpuat;
            //writeln(lastinpuat);
            kala = "";
            foreach(k, l; iu)
            {
                iu[k] = 0;
            }
        } else {
            lastinput = kala;
            str["s"] = lastinput;
            kala = "";
            foreach(k, l; iu)
            {
                iu[k] = 0;
            }
        }
    } else if (line.value.startsWith("\"") && line.value.endsWith("\""))
    {
        string ha = line.value;
        ha = ha.replace("\"", "");
        write(ha);
    } else if (line.value.startsWith("@"))
    {
        string lala = line.value.replace("@", "");
        //writeln(lala);
        if (lala in int_s)
        {
            write(int_s[lala]);
        }
    } else if (line.value.startsWith("%"))
    {
        string lala = line.value.replace("%", "");
        //writeln(lala);
        if (lala in str)
        {
            write(str[lala]);
        }
    }
    }
}