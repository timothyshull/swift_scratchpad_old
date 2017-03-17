//
//  MainWindowController.swift
//  Thermostat
//
//  Created by Tim Shull on 9/20/16.
//  Copyright © 2016 Tim Shull. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
//    dynamic var temperature = 68
    var temperature = 68
    var isOn = true
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }

    // prefer this method over setValue(_ :,forKey:) and
    // dynamic as it is better in larger apps
    @IBAction func makeWarmer(sender: NSButton) {
        willChangeValue(forKey: "temperature")
        temperature += 1
        didChangeValue(forKey: "temperature")
    }
    
    @IBAction func makeCooler(sender: NSButton) {
        willChangeValue(forKey: "temperature")
        temperature -= 1
        didChangeValue(forKey: "temperature")
    }
    
}
