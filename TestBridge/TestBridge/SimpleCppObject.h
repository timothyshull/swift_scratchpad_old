//
//  SimpleCppObject.h
//  TestBridge
//
//  Created by Timothy Shull on 1/30/16.
//  Copyright © 2016 Timothy Shull. All rights reserved.
//

#ifndef SimpleCppObject_h
#define SimpleCppObject_h

#include <iostream>

class SimpleCppObject {
public:
    
    SimpleCppObject() {
        std::cout << "In the foo!" << std::endl;
        std::string someString {"hello from a C++ constructor!"};
        std::cout << someString << std::endl;
    }
    
    int addNums(int x, int y);
};

#endif /* SimpleCppObject_h */
