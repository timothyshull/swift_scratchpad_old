//
//  SimpleObjcObject.h
//  TestBridge
//
//  Created by Timothy Shull on 1/30/16.
//  Copyright © 2016 Timothy Shull. All rights reserved.
//

#ifndef SimpleObjcObject_h
#define SimpleObjcObject_h

#import <Foundation/Foundation.h>

@interface SimpleObjcObject : NSObject {
    int z;
}

-(int)addX:(int)x andY:(int)y;

@end

#endif /* SimpleObjcObject_h */
