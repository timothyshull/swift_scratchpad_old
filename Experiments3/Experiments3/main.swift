#!/usr/bin/swift

import Foundation

let file = "file.txt" //this is the file. we will write to and read from it

let text = "some text" //just a text

if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
    let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(file)
    
    //writing
    do {
        try text.writeToURL(path, atomically: false, encoding: NSUTF8StringEncoding)
    }
    catch {/* error handling here */}
    
    //reading
    do {
        let text2 = try NSString(contentsOfURL: path, encoding: NSUTF8StringEncoding)
    }
    catch {/* error handling here */}
}

// for vars use var.dynamicType
// for classes use Class.self
// use toString()

func testFunc() -> Void {
    
}

var i = 0;
for arg in Process.arguments {
    let index = Int(i);
    
    //    let arg = String.fromCString(C_ARGV[index])
    switch arg {
    case "this":
        print("this yo");
        
    case "that":
        print("that yo")
        
    default:
        print("dunno bro")
    }
}

var fh = NSFileHandle.fileHandleWithStandardInput()

print("What is your name?")

if let data:NSData? = fh.availableData {
    var str = NSString(data: data!, encoding: NSUTF8StringEncoding)
    print("Your name is \(str)")
}

print("I will repeat strings back at you:")
waitingOnInput: while true {
    if let data:NSData? = fh.availableData {
        var str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print(str)
    }
}

// Let's define a basic Swift class.
class Fruit {
    var type = 1
    var name = "Apple"
    var delicious = true
}

let fruitMirror = Mirror(reflecting: Fruit)
print(fruitMirror)

for case let (label?, value) in fruitMirror.children {
    print (label, value)
}

// Dump a bunch of info about the object using reflection.
dump(Fruit())

// Let's make an instance and print all its properties to the console.
var theFruit = Fruit()

let fruitMirror2 = Mirror(reflecting: theFruit)

for child in fruitMirror2.children {
    print(child)
}
