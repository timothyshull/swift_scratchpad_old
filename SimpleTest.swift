import UIKit

var str = "Hello, playground"

let path = "/Users/skull"

let fileManager = FileManager()     // let fileManager = NSFileManager.defaultManager()
let en = fileManager.enumerator(atPath: path)   // let enumerator:NSDirectoryEnumerator = fileManager.enumeratorAtPath(folderPath)

while let element = en?.nextObject() as? String {
    print(element)
    if element.hasSuffix("ext") {
        print(element)
        // do something with the_path/*.ext ....
    }
}