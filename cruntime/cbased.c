#include "cbased.h"
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <math.h>
void* _calloc(size_t num, size_t size)
{
    void* al = calloc(num, size);
    if (al == NULL)
    {
        return 0;
    } else {
        return al;
    }
}


void _abort()
{
	exit(0);
}

//void _atexit()
//{

//}

//atexit must define in compiler itself

int _abs(int num)
{
	return abs(num);
}

double _acos(double arg)
{
	if (arg >=  -1.0 && arg <= 1.0){
		return acos(arg);
	} else {
		return 0.0;
	}
}
double _asin(double asina)
{
	if (asina >= -1.0)
	{
		if (asina <= 1.0){
			return asin(asina);
		} else {
			return 0.0;
		}
	} else {
		return 0.0;
	}
}

double _atan2(double x, double y)
{
	return atan2(x, y);
}
