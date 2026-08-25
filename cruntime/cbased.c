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


double _exp(double arg)
{
	if (arg > 709.8 || arg < -708.9)
	{
			printf("Core fault: `exp` value cant be bigger then 709.8, and cant be lower then 708.9");
			_abort();
	} else {
			return exp(arg);
	}
}

double _cos(double arg){
	return cos(arg);
}

double _cosh(double arg){
	return cosh(arg);
}

double _fabs(double num)
{
	return fabs(num);
}

double _floor(double num)
{
	return floor(num);
}

double _fmod(double x, double y){
	return fmod(x, y);
}

double _frexp(double num, int *exp){
	return frexp(num, exp);
}

double _ldexp(double num, int exp){
	return ldexp(num, exp);
}

double _hypot(double x, double y)
{
	return hypot(x, y);
}

double _log(double num)
{
	return log(num);
}

double _log10(double num)
{
	return log10(num);
}

double _modf(double num, double *i)
{
	return modf(num, i);
}

double _pow(double base, double exp)
{
		return pow(base, exp);
}

double _sin(double arg)
{
	return sin(arg);
}

double _sinh(double arg)
{
	return sinh(arg);	
}

double _sqrt(double arg)
{
	return sqrt(arg);	
}

double _tan(double num)
{
	return tan(num);
}

double _tanh(double arg)
{
	return 	tanh(arg);
}

double _ceil(double num)
{
	return ceil(num);
}