//: Playground - noun: a place where people can play

import Cocoa

var errorCodeString: String?
print(errorCodeString)
errorCodeString = "404"
print(errorCodeString)
var testStr: String!
testStr = "test"
if errorCodeString != nil {
    let theError = errorCodeString!
    print(theError)
}
