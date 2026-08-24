module cslm.proc;

import std.stdio, std.regex, std.algorithm, std.string, std.file, core.stdc.stdlib, cslm.randomnameforvalue;
import std.ascii, std.conv, std.range;
int[string] aaa;
void proce(string line, string filrn, string mode, string kka)
{
    int ppa = 0;
    int ma = 0;
    int br = 0;
    string final_asm;
    string[] savetoglobal;
    bool kak = false;
    string[] ranname;
    string[] kk = line.splitLines();
    int o = -1;
    foreach(oo; kk)
    {
        //writeln(oo);
        string[] linea = oo.split(' ');
        foreach (inw, aika; linea)
        {
            if (mode == "d")
            {
            writeln(linea);
            writeln(final_asm);
            writeln(aika);
            writeln(ma);
            writeln(kak);
            }
            if (aika.startsWith("(") && aika.endsWith(")"))
            {
                aika = aika.replace("(", "");
                aika = aika.replace(")", "");
                aika = aika.strip();
                string[] aa = aika.split(",");
                if (aa[0] == "s")
                {
                //section.
                if (aa[1] == "data")
                {
                    final_asm = final_asm ~ "\n" ~ "section .data";
                } else if (aa[1] == "code")
                {
                    final_asm = final_asm ~ "\n" ~ "section .code";
                } else if (aa[1] == "text")
                {
                    final_asm = final_asm ~ "\n" ~ "section .text";
                }
            }
        } else if (aika == ("_main"))
        {
            final_asm = final_asm ~ "\n" ~ "section .text\n\tglobal _start\n_start:";
            ma = 1;
            kak = true;
        } else if (aika == ("{"))
        {
            if (kak)
            {
                br = 1;
            }
        } else if (aika.startsWith("pr(") && aika.endsWith(");") && kak && br == 1)
        {
            if (mode == "d")
            {
            writeln(aika);
            }
            auto ll = regex(`pr\((\S+)\)\;`);
            auto ll2 = match(aika, ll);
            if (!ll2.empty)
            {

                if (mode == "d")
                {
                writeln(ll2.captures[1]);
                }
                if (ll2.captures[1].indexOf("\"") != -1)
                {
                    
                    string nam = randa();
                    ranname ~= nam;                
                    savetoglobal ~= ll2.captures[1].replace("\\s", " ").idup;
                    int kp = to!int(to!string(ll2.captures[1]).indexOf("%")) + 1;
                    //writeln(to!string(ll2.captures[1]).indexOf("%"));
                    string laa = ll2.captures[1];
                    if (mode == "d")
                    {
                        writeln(aaa);
                        writeln(kp);
                    }
                    if (kp != 0)
                    {
                    savetoglobal ~= ll2.captures[1].replace("%" ~ laa[kp], to!string(aaa[to!string(laa[kp])]));
                    //final_asm = final_asm ~ "\n" ~ "mov rax, 1\nmov rdi, 1\nmov rsi, " ~ nam ~"\nmov rdx, len" ~ nam ~ "\nsyscall";
                    }
                                        final_asm = final_asm ~ "\n" ~ "mov rax, 1\nmov rdi, 1\nmov rsi, " ~ nam ~"\nmov rdx, len" ~ nam ~ "\nsyscall";

                }
                if (mode == "d"){
                writeln(final_asm);
                }
            } else {
                writeln("b1");
            }
            
        } else if(aika.startsWith("return(") && aika.endsWith(");") && kak && br == 1)
        {

            if (mode == "d") writeln("it found");
                auto ll = regex(`return\((\S+)\)\;`);
                auto ll2 = match(aika, ll);
                if (!ll2.empty)
                {
                    if (ll2.captures[1] == "0E")
                    {
                        final_asm = final_asm ~ "\n" ~ "mov rax, 60\nmov rdi, 0\nsyscall";
                        if (savetoglobal != null)
                    {
                    //final_asm = "section .data\nmsg db \'" ~ savetoglobal ~ "\', 10";
                        if (kak)
                        {
                            foreach(lo, oop; ranname)
                            {
                                string qll = savetoglobal[lo].replace("\"", "\'");
                                if (qll.indexOf("\\n") != -1)
                                {
                                    if (qll.indexOf("\\n") == qll.length) 
                                    {
                                        qll = qll.replace("\\n", "\', 0x0A");
                                    } else {
                                        qll = qll.replace("\\n", "\', 0x0A, \'");
                                    }
                                } else if (ppa == 1)
                                {
                                    foreach(ak, lk; aaa)
                                    {
                                        final_asm = final_asm ~ "section .data\n\t" ~ ak ~ "\tdd\t" ~ to!string(aaa);
                                    }
                                }
                                final_asm = "extern printf\nsection .data\n\t" ~ oop ~ " db " ~ qll ~ "\n\tlen" ~ oop ~ " equ $ - " ~ oop ~"\n\n" ~ final_asm;
                            }
                            
                        } else { 
                            final_asm = "extern printf\nsection .data\nmsg db \'" ~ savetoglobal[0] ~ "\', 10\n\n" ~ final_asm;
                        }
                    }
                    } else {
                        writeln("JUST SUPPORT 0E FOR NOW.");
                        exit(0);
                    }
                }
                
        } else if (aika == ("}"))
        {
            if (mode == "d") writeln("bre");
            if (ma == 1 && br == 1)
            {
                br = 0;
                ma = 0;
                kak = false;
            }
        } else if (aika.startsWith("__int") && aika.endsWith(");"))
        {
            if (mode == "d")
            {
            writeln(aika);
            }
            auto ll = regex(`__int\((\S+), (\S+)\);`);
            auto ll2 = match(aika, ll);
            if (!ll2.empty)
            {
                if (mode == "d")
                {
                writeln(ll2.captures[1]);
                }
                int modae = 0;
                auto laa = ll2.captures[1].split(",");
                //laa = laa.remove(0);
                aaa[ll2.captures[1]] = to!int(ll2.captures[1]);
                ppa = 1;
                if (mode == "d"){
                writeln(final_asm);
                }
            } else {
                writeln("b1");
            }
            
        } else if (aika.startsWith("pr__int(") && aika.endsWith(");"))
        {
            auto ll = regex(`pr__int\((\S+)\);`);
            auto ll2 = match(aika, ll);
            if (!ll2.empty)
            {
                if (ll2.captures[1] in aaa)
                {
                    final_asm = final_asm ~ "\n" ~ "\tmov\tedi, format\n\tmov\tesi, [" ~ ll2.captures[1] ~ "]\n\txor\teax, eax\n\tcall printf";
                } else { writeln("ERR"); }
            }
        }


    }
    }
    
    
    if (kka == "d") writeln(final_asm);
    std.file.write(filrn.replace(".csc", "") ~ ".s", final_asm);
    if (exists(filrn.replace(".csc", "") ~ ".s"))
    {
        system(toStringz("nasm -f elf64 " ~ filrn.replace(".csc", "") ~ ".s" ~ " -o " ~ filrn.replace(".csc", "") ~ ".o"));
        system(toStringz("ld " ~ filrn.replace(".csc", ".o") ~ " -o " ~ filrn.replace(".csc", "")));
    }
    if (exists(filrn.replace(".csc", "")))
    {
    remove(filrn);
    remove(filrn.replace(".csc", ".o"));
    remove(filrn.replace(".csc", ".s"));
    } else { writeln("Faild to compile. check error(s) and try again."); }
}