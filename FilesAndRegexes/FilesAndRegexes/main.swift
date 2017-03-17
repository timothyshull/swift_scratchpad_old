//
//  main.swift
//  FilesAndRegexes
//
//  Created by Tim Shull on 10/14/16.
//  Copyright © 2016 Tim Shull. All rights reserved.
//

import Foundation
import Cocoa

let file = "file.txt" //this is the file. we will write to and read from it

let text = "some text" //just a text

if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
    
    let path = dir.appendingPathComponent(file)
    
    //writing
    do {
        try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
    }
    catch {/* error handling here */}
    
    //reading
    do {
        let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
    }
    catch {/* error handling here */}
}



// (1):
let pat = "\\b([a-z])\\.([a-z]{2,})@([a-z]+)\\.ac\\.uk\\b"
// (2):
let testStr = "x.wu@strath.ac.uk, ak123@hotmail.com     e1s59@oxford.ac.uk, ee123@cooleng.co.uk, a.khan@surrey.ac.uk"
// (3):
let regex = try! NSRegularExpression(pattern: pat, options: [])
// (4):
let matches = regex.matches(in: testStr, options: [], range: NSRange(location: 0, length: testStr.characters.count))

for match in matches {
    for n in 0..<match.numberOfRanges {
        let range = match.rangeAt(n)
        let r = testStr.startIndex.advancedBy(range.location);
        testStr.startIndex.advancedBy(range.location+range.length)
        testStr.substringWithRange(r)
    }
}


typealias PossibleDate = (year: Int, month: Int, day: Int)
// (2):
func dateSearch(text: String, _ date: PossibleDate) -> Bool {
    
    // (3):
    let datePattern = "\\b(?:20)?(\\d\\d)[-./](0?[1-9]|1[0-2])[-./](3[0-1]|[1-2][0-9]|0?[1-9])\\b"
    
    let dateRegex = try! NSRegularExpression(pattern: datePattern,
                                             options: [])
    // (4):
    var wasFound: Bool = false
    // (5):
    dateRegex.enumerateMatchesInString(text, options: [],
                                       range: NSRange(location: 0,
                                                      length: text.characters.count)) {
                                                        // (6):
                                                        (match, _, stop) in
                                                        var dateArr = [Int]()
                                                        for n in 1...3 {
                                                            let range = match!.rangeAtIndex(n)
                                                            let r = text.startIndex.advancedBy(range.location) ..<
                                                                text.startIndex.advancedBy(range.location+range.length)
                                                            dateArr.append(Int(text.substringWithRange(r))!)
                                                            
                                                        }
                                                        // (7):
                                                        if dateArr[0] == date.year
                                                            && dateArr[1] == date.month
                                                            && dateArr[2] == date.day {
                                                            // (8):
                                                            wasFound = true
                                                            stop.memory = true
                                                        }
    }
    
    return wasFound
}

let text = "   2015/10/10,11-10-20,     13/2/2     1981-2-2   2010-13-10"

let date1 = PossibleDate(15, 10, 10)
let date2 = PossibleDate(13, 1, 1)

dateSearch(text, date1) // returns true
dateSearch(text, date2) // returns false
