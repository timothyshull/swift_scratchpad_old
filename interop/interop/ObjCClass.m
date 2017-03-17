//
// Created by Timothy Shull on 7/6/16.
// Copyright (c) 2016 tim_shull. All rights reserved.
//

#import "ObjCClass.h"


@implementation ObjCClass {
    int _secondVar;
}

- (void)setSecondVar:(int)firstParam {
    _secondVar = firstParam;
}

- (int)getSecondVar {
    return _secondVar;
}

@end