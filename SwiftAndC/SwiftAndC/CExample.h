#ifndef SWIFTANDC_CEXAMPLE_H
#define SWIFTANDC_CEXAMPLE_H

#include <stdio.h>

#define CEX_GLOBAL_DEFINE 536

void printSomething();

void passAnUnsafePointer(const int *param);

void passAnUnsafeMutablePointer(int *param);

void passAConstCharPointer(const char *param);

typedef void (*fptrType)(void);

fptrType functionThatReturnsAFunction(int i);

typedef void (*ctxFptrType)(void *ctx);

void aCFunctionThatTakesAContext(void *ctx, ctxFptrType);

typedef struct CexStruct_ {
    char name[5];
    int value;
} CexStruct;

char cStr[] = "Array string";
const char *cPtrStr = "Pointer string";

union CexUnion {
    int i;
    float f;
    unsigned char valAsChar[4];
} cexUnion;

#endif // SWIFTANDC_CEXAMPLE_H