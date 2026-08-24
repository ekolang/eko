module error;

import std.stdio;
import core.stdc.stdlib, std.conv;
enum kodes
{
    _no_value = "01234",
    _no_file = "23459",
    _syntex_faild = "88989",
    _eerror = "88819",
    _file_faild = "0919019",
    _gclear_faild = "0918398"
}

void prinPanic(kodes code, string lin)
{
    if (code == kodes._no_value)
    {
        
        writeln("\033[31m\033[1mError: \033[0m" ~ "The variable whose value you requested does not exist.");
        writeln("\tThis error was received due to the following line:");
        writeln("\t\t" ~ lin);
        write("\t\t");
        for(int i = 0; i < cast(int)lin.length; i++)
        {
            write("\033[32m\033[1m^");
        }
        write("\n");
        writeln("\033[31m\033[1mExited with code \033[0m1.");
        exit(1);
    } else if (code == kodes._no_file)
    {
        writeln("\033[31m\033[1mError: \033[0m" ~ "The imported file does not exist on this disk or in this directory.");
        writeln("\tThis error was received due to the following line:");
        writeln("\t\t" ~ lin);
        write("\t\t");
        for(int i = 0; i < cast(int)lin.length; i++)
        {
            write("\033[32m\033[1m^");
        }
        writeln("\033[31m\033[1mExited with code \033[0m1.");
        exit(1);
    } else if(code == kodes._eerror)
    {
        
        writeln("\033[31m\033[1mError: \033[0m" ~ "An unexpected error occurred that could not be handled.");
        writeln("\tThis error was received due to the following line:");
        writeln("\t\t" ~ lin);
        write("\t\t");
        for(int i = 0; i < cast(int)lin.length; i++)
        {
            write("\033[32m\033[1m~");
        }
        writeln("\033[31m\033[1mExited with code \033[0m1.");
        exit(1);
    } else if (code == kodes._file_faild)
    {
        writeln("\033[31m\033[1mError: \033[0m" ~ "An unexpected error occurred that could not be handled.");
        writeln("\tThis error was received due to the following line:");
        writeln("\t\t" ~ lin);
        write("\t\t");
        for(int i = 0; i < cast(int)lin.length; i++)
        {
            write("\033[32m\033[1m~");
        }
        writeln("\033[31m\033[1mExited with code \033[0m1.");
        exit(1);
    } else if (code == kodes._syntex_faild)
    {
        writeln("\033[31m\033[1mError: \033[0m" ~ "Syntax Error: Invalid syntax. Please check your spelling, brackets, and quotation marks at line.");
        writeln("\tThis error was received due to the following line:");
        writeln("\t\t" ~ lin);
        write("\t\t");
        for(int i = 0; i < cast(int)lin.length; i++)
        {
            write("\033[32m\033[1m~");
        }
        writeln("\033[31m\033[1mExited with code \033[0m1.");
        exit(1);
    } else if (code == kodes._gclear_faild)
    {
        writeln("\033[31m\033[1mError: \033[0m" ~ "The entered color is not valid.");
        writeln("\tThis error was received due to the following line:");
        writeln("\t\t" ~ lin);
        write("\t\t");
        for(int i = 0; i < cast(int)lin.length; i++)
        {
            write("\033[32m\033[1m~");
        }
        writeln("\033[31m\033[1mExited with code \033[0m1.");
        exit(1);
    }
}