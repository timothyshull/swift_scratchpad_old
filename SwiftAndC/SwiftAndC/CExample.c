#include "CExample.h"
#include <stdio.h>
#include <unistd.h>
#include <string.h>

void printSomething() {
    printf("Printing from a C function");
};

void passAnUnsafePointer(const int *param) {
    printf("The unsafe, non-mutable (const) pointer is at memory %p\n", param);
    printf("The unsafe, non-mutable (const) pointer has a value of %d\n", *param);
};

void passAnUnsafeMutablePointer(int *param) {
    printf("The unsafe, mutable (non-const) pointer is at memory %p\n", param);
    printf("The unsafe, mutable (non-const) pointer has a value of %d\n", *param);
};

void passAConstCharPointer(const char *param) {
    printf("The length of string is %lu\n", strlen(param));
    printf("The length of string is %lu\n", sizeof(*param));
};

//typedef void (*fptrType)(void);

void printAdd() {
    printf("add");
}

void printSubtract() {
    printf("subtract");
}

fptrType functionThatReturnsAFunction(int i) {
    if (i == 0) {
        return printSubtract;
    } else {
        return printAdd;
    }
};

//typedef void (*ctxFptrType)(void *ctx);
void ctxCback(void *ctx) {
    printf("Printing context: %d", *((int *) ctx));
}

void aCFunctionThatTakesAContext(void *ctx, ctxFptrType func) {
    func(ctx);
};