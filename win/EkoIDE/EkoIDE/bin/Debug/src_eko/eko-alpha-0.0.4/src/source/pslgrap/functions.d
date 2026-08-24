module ekograp.functions;

import std.stdio;
import arsd.simpledisplay, error, std.regex, std.algorithm, std.conv;

SimpleWindow[string] windows;
string[] graphic_commends;
Point[string] psave;
ScreenPainter aa;
void clearscreen(SimpleWindow mainscreen, string color, string line)
{
    if (color == "white")
    {
        graphic_commends ~= "clearwhite";
    } else if (color == "black")
    {
        graphic_commends ~= "clearblack";
    } else if (color == "red")
    {
        graphic_commends ~= "clearred";
    } else {
        prinPanic(kodes._gclear_faild, line);
    }
}
void windowshow(SimpleWindow mainscreen)
{
    mainscreen.eventLoop();
}

SimpleWindow initscreen(string title, int size1, int size2)
{
    return new SimpleWindow(size1, size2, title);
}

void toLocation(string name, int num1, int num2)
{
    psave[name] = Point(num1, num2);
}
