#ifdef CBASED_H
#define CBASED_H

#include <stddef.h>

void* _calloc(size_t num, size_t size);
void _abort();
int _abs(int num);
double _acos(double arg);
double _atan2(double x, double y);
double _asin(double asina);
double _exp(double arg);
double _fabs(double num);
double _floor(double num);
double _fmod(double x, double y);
double _frexp(double num, int *exp);
double _sinh(double arg);
double _sqrt(double num);
double _tan(double arg);
double _tanh(double arg);
double _ceil(double num);
double _cos(double arg);
double _cosh(double arg);
double _log(double num);
double _log10(double num);
double _modf(double num, int *i);
double _hypot(double x, double y);
double _ldexp(double num, int exp);
double _pow(double base, double exp);
double _sin(double arg);
#endif
