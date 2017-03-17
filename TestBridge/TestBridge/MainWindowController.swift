//
//  MainWindowController.swift
//  TestBridge
//
//  Created by Timothy Shull on 1/30/16.
//  Copyright © 2016 Timothy Shull. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    var testVal = 33
    var inVal1 = 0
    var inVal2 = 0
    var outVal = 0
    
    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @IBAction func runPureObjC(sender: NSButton) {
        let foo = SimpleObjcObject()
        let val1 = Int32(inVal1)
        let val2 = Int32(inVal2)
        print(val1)
        print(val2)
        outVal = Int(foo.addX(val1, andY: val2))
        setValue(outVal, forKey: "outVal")
        print(outVal)
    }
    
    @IBAction func cppViaObjc(sender: NSButton) {
        let testCpp = ObjcCppObject()
        let valToUse: Int = Int(testCpp.playWithFoo())
        self.messageBox(valToUse)
    }
    
    func messageBox(inVal: Int) {
        let alert = NSAlert()
        alert.messageText = "Added value from cpp: \(inVal)"
        alert.beginSheetModalForWindow(window!, completionHandler: closeHandler)
    }
    
    func closeHandler(response: NSModalResponse) {
        return
    }
    
}