//
//  ObjcCppObject.m
//  TestBridge
//
//  Created by Timothy Shull on 1/30/16.
//  Copyright © 2016 Timothy Shull. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "ObjcCppObject.h"
#include "SimpleCppObject.h"

@implementation ObjcCppObject

-(int)playWithFoo {
    SimpleCppObject foo;
    return foo.addNums(25, 25);
}

@end