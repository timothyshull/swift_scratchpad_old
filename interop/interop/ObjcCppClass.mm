//
// Created by Timothy Shull on 7/6/16.
// Copyright (c) 2016 tim_shull. All rights reserved.
//

#import "ObjcCppClass.h"
#import "CppClass.h"

@implementation ObjcCppClass

- (int)pointlesAddCpp:(int)otherAdd {
    CppClass testClass;
    return testClass.pointless_add(otherAdd);
}

@end