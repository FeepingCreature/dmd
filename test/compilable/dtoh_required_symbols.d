/*
REQUIRED_ARGS: -o- -HC
TEST_OUTPUT:
---
// Automatically generated by Digital Mars D Compiler

#pragma once

#include <assert.h>
#include <stddef.h>
#include <stdint.h>
#include <math.h>

#ifdef CUSTOM_D_ARRAY_TYPE
#define _d_dynamicArray CUSTOM_D_ARRAY_TYPE
#else
/// Represents a D [] array
template<typename T>
struct _d_dynamicArray
{
    size_t length;
    T *ptr;

    _d_dynamicArray() : length(0), ptr(NULL) { }

    _d_dynamicArray(size_t length_in, T *ptr_in)
        : length(length_in), ptr(ptr_in) { }

    T& operator[](const size_t idx) {
        assert(idx < length);
        return ptr[idx];
    }

    const T& operator[](const size_t idx) const {
        assert(idx < length);
        return ptr[idx];
    }
};
#endif

struct ExternDStruct;
enum class ExternDEnum
{
    A = 0,
};

class ExternDClass;

struct ExternDStruct
{
    int32_t i;
    double d;
    ExternDStruct() :
        i(),
        d()
    {
    }
    ExternDStruct(int32_t i, double d = NAN) :
        i(i),
        d(d)
        {}
};

template <>
struct ExternDStructTemplate
{
    // Ignoring var i alignment 0
    int32_t i;
    // Ignoring var d alignment 0
    double d;
    ExternDStructTemplate()
    {
    }
};

struct ExternCppStruct
{
    ExternDStruct s;
    ExternDEnum e;
    ExternDStructTemplate< > st;
    ExternCppStruct() :
        s(),
        st()
    {
    }
    ExternCppStruct(ExternDStruct s, ExternDEnum e = (ExternDEnum)0, ExternDStructTemplate< > st = ExternDStructTemplate< >(0, NAN)) :
        s(s),
        e(e),
        st(st)
        {}
};

extern ExternDClass* globalC;

extern void foo(int32_t arg = globalC.i);
---

Known issues:
- class declarations must be emitted on member access
*/

// extern(D) symbols are ignored upon first visit but required later

struct ExternDStruct
{
	int i;
	double d;

	// None of these can be emitted due to the mismatched mangling
	static double staticDouble;
	static shared double staticSharedDouble;
	__gshared double sharedDouble;
}

class ExternDClass
{
	int i;
	double d;
}

enum ExternDEnum
{
	A
}

struct ExternDStructTemplate()
{
	int i;
	double d;
}

extern (C++):

struct ExternCppStruct
{
	ExternDStruct s;
	ExternDEnum e;
	ExternDStructTemplate!() st;
}

__gshared ExternDClass globalC;

void foo(int arg = globalC.i) {}
