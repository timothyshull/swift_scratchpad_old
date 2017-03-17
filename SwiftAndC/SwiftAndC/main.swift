//
//  main.swift
//  SwiftAndC
//
//  Created by Tim Shull on 9/18/16.
//  Copyright © 2016 Tim Shull. All rights reserved.
//

import Foundation
import CExample


//: ### Arrays and Structs
//:

print(CEX_GLOBAL_DEFINE)

let ms = CexStruct(name: (0, 0, 0, 0, 0), value: 1)
print(ms)


//: ### Unions

cexUnion.i = 33
print(cexUnion.f)  // 4.624285e-44
print(cexUnion.i)  // 33
print(cexUnion.valAsChar) // (33, 0, 0, 0)

cexUnion.f = 1234567
print(cexUnion.f)  // 1234567
print(cexUnion.i)  // 1234613304
print(cexUnion.valAsChar) // (56, 180, 150, 73)

var fv: Float32 = unsafeBitCast(Int32(33), to: Float.self)

print(MemoryLayout<CexUnion>.stride)  // 4 bytes

//: ### The size of things
//:

print(MemoryLayout<CChar>.stride)  // 1

struct Struct1 {
    let anInt8: Int64
    let anInt: Int16
    let b: Bool
}

print(MemoryLayout<Struct1>.size)    // 11 (8+2+1)
print(MemoryLayout<Struct1>.stride)  // 16 (8+4+4)

//: ### Macros
//:

//IAMADEFINE  //42


//: ### Working with Pointers
//:

var i: Int32 = 42
passAnUnsafePointer(&i);


let namestr = withUnsafePointer(to: &cStr, {
    (ptr) -> String? in
//    let charPtr = UnsafeMutablePointer<CChar>(ptr)
//    charPtr[2] = 35 // # character
//    return String.fromCString(charPtr)
    return "tmp"
})
print(namestr!) //IAmAString


let array: [Int8] =
[65, 66, 67, 0]
puts(array)  // ABC
array.withUnsafeBufferPointer {
    (ptr:UnsafeBufferPointer<Int8>) in
    puts(ptr.baseAddress! + 1) //BC
}

//: ### Allocating memory
//:

var ptr = UnsafeMutablePointer<CChar>.allocate(capacity: 10)
//Or alternatively: var ptr = UnsafeMutablePointer<CChar>(malloc(10*strideof(CChar)))

ptr.initializeFrom(0, count: 10)

//Do something with the object
ptr[3] = 42

ptr.deinitialize() //Clean up

ptr.deallocate(capacity: 10) //Let's free the memory we allocated
//Or alternatively: free(ptr)


var sptr = UnsafeMutablePointer<String>.allocate(capacity: 1)
sptr.initialize(to: "Test String")
print(sptr.pointee)

sptr.deinitialize()
sptr.deallocate(capacity: 1)

//: Is initialization really necessary?

struct CexStruct1 {
    var int1: Int
    var int2: Int
}

var s1ptr = UnsafeMutablePointer<CexStruct1>.allocate(capacity: 5)

s1ptr[0] = CexStruct1(int1: 1, int2: 2)
s1ptr[1] = CexStruct1(int1: 1, int2: 2) //Doesn't seems so, this always works!

s1ptr.deinitialize()
s1ptr.deallocate(capacity: 5)

//: Let's try introducing a reference type property to CexStruct

class TestClass {
    var aField: Int = 0
}

struct CexStruct2 {
    var int1: Int
    var int2: Int
    var tc: TestClass
}

var s2ptr = UnsafeMutablePointer<CexStruct2>.allocate(capacity: 5)
s2ptr.initialize(from: [CexStruct2(int1: 1, int2: 2, tc: TestClass()), // Remove the initialization
                        CexStruct2(int1: 1, int2: 2, tc: TestClass())])  // and you'll have a crash below

s2ptr[0] = CexStruct2(int1: 1, int2: 2, tc: TestClass())
s2ptr[1] = CexStruct2(int1: 1, int2: 2, tc: TestClass())

s2ptr.deinitialize()
s2ptr.deallocate(capacity: 5)


//: Other examples from the malloc family:

var val = [CChar](repeatedValue: 1, count: 10)
var buf = [CChar](count: val.count, repeatedValue: 0)
memcpy(&buf, &val, buf.count * strideof(CChar))
buf

let mptr = UnsafeMutablePointer<Int>(mmap(nil, Int(getpagesize()), PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0))
mptr[0] = 3

munmap(ptr, Int(getpagesize()))

//: ### Pointer arithmetic
//:

var aptr = UnsafeMutablePointer<CChar>.allocate(capacity: 5)
aptr.initialize(from: [33, 34, 35, 36, 37])

print(aptr.successor().pointee) // 34
print(aptr.advanced(by: 3).pointee) // 36
print(aptr.advancedBy(3).predecessor().memory) // 35

print(aptr.distance(to: aptr.advancedBy(3))) // 3


print((aptr + 1).pointee) // 34
print((aptr + 3).pointee) // 36
print(((aptr + 3) - 1).pointee) // 35

aptr.deinitialize()
aptr.deallocate(capacity: 5)

//: ### Working with strings
//:

puts("Hey! I was a Swift string!")

var testString = "AAAAA"

testString.withCString {
    (ptr:UnsafePointer<Int8>) -> Void in
    // Do something with ptr
    functionThatExpectsAConstCharPointer(ptr)
}


let swiftString = String.fromCString(CE_OtherName)

func isPrintable(text:String) -> Bool {
    for scalar in text.unicodeScalars {
        let charCode = scalar.value
        guard (charCode > 31) && (charCode < 127) else {
            return false // Unprintable character
        }
    }
    return true
}

print(isPrintable(text: "No, it's not 😅"))


//: ### Working with closures
//:

printStuff(); // Imported C function defined in CExample.c

let fun = returnAFunction(); // Imported C function defined in CExample.c
fun()

//: Unmanaged

class AClass: CustomStringConvertible {

    var aProperty: Int = 0

    var description: String {
        return "A \(type(of: self)) with property \(self.aProperty)"
    }
}

var value = AClass()

let unmanaged = Unmanaged.passRetained(value)
let uptr = unmanaged.toOpaque()
let vptr = UnsafeMutableRawPointer(uptr)

aCFunctionWithContext(vptr) {
    (p:UnsafeMutableRawPointer) -> Void in
    var c = Unmanaged<AClass>.fromOpaque(COpaquePointer(p)).takeUnretainedValue()
    c.aProperty = 2
    print(c) //A AClass with property 2
}


