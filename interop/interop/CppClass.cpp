//
// Created by Timothy Shull on 7/6/16.
// Copyright (c) 2016 tim_shull. All rights reserved.
//

#include "CppClass.h"

int CppClass::get_my_var() {
    return my_var;
}

void CppClass::set_my_var(int new_var) {
    my_var = new_var;
}

int CppClass::pointless_add(int oper) {
    return 11 + oper;
}