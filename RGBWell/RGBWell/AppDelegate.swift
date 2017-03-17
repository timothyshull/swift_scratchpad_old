//
//  AppDelegate.swift
//  RGBWell
//
//  Created by Tim Shull on 9/14/16.
//  Copyright © 2016 Tim Shull. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowController: MainWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mwc = MainWindowController()
        mwc.showWindow(self)
        self.mainWindowController = mwc
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

