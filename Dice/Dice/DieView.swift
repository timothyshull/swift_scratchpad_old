//
// Created by Timothy Shull on 7/8/16.
// Copyright (c) 2016 Timothy Shull. All rights reserved.
//

import Cocoa

class DieView: NSView {
    override func drawRect(dirtyRect: NSRect) {
        let backgroundColor = NSColor.lightGrayColor()
        backgroundColor.set()
        NSBezierPath.fillRect(bounds)

        NSColor.greenColor().set()
        let path = NSBezierPath()
        path.moveToPoint(NSPoint(x: 0, y: 0))
        path.lineToPoint((NSPoint(x: bounds.width, y: bounds.height)))
        path.stroke()
    }
    
}
