//
//  main.swift
//  interop
//
//  Created by Timothy Shull on 7/6/16.
//  Copyright (c) 2016 tim_shull. All rights reserved.
//

import Foundation


var testVar: ObjCClass = ObjCClass();
testVar.setSecondVar(10);
print(testVar.getSecondVar());

var testVar2: ObjcCppClass = ObjcCppClass();
print(testVar2.pointlesAddCpp(25));