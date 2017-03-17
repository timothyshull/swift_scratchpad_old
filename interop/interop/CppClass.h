//
// Created by Timothy Shull on 7/6/16.
// Copyright (c) 2016 tim_shull. All rights reserved.
//

#ifndef INTEROP_CPPCLASS_H
#define INTEROP_CPPCLASS_H


class CppClass {
private:
    int my_var{10};
public:
    int get_my_var();
    void set_my_var(int new_var);
    int pointless_add(int oper);
};


#endif //INTEROP_CPPCLASS_H
