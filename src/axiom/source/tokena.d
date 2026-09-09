module tokena;
import std.stdio;

string[] Tokenlz(string line)
{
	string[] result;
	string curent;
	bool inString = false;
	bool inParan = false;
	bool inBr = false;
	foreach(char a; line)
	{
		//write(a);
		if (a == '"' && (inParan == false))
		{
			if (inString == false){
				result ~= curent;
				curent = "";
				curent ~= a;
				inString = !inString;
				continue;
			}
			inString = !inString;
			curent ~= a;
			continue;
		} else if (a == '}' && inBr && inString){
			curent ~= a;
			result ~= curent;
			curent = "";
			inBr = false;
			continue;
	 	} else if (inBr && inString){
			curent ~= a;
			continue;
		} else if (inString == false && a == '(')
		{
			inParan = true;
			continue;
		} else if (inString == false && inParan == true && a == ')')
		{
			inParan = false;
			result ~= curent;
			curent = "";
			continue;
		} else if(a == ' ' && !inParan){
			if (inString == true)
			{
				curent ~= a;
			} else if (curent.length > 0)
			{
				result ~= curent;
				curent = "";
				continue;
			}
		} else if(a == '{' && inString){
			inBr = true;
			result ~= curent;
			curent = "";
			curent ~= a;
			continue;
		} else {
			curent ~= a;
			continue;
		}
	}
	if (curent.length > 0) result ~= curent;
	return result;
}