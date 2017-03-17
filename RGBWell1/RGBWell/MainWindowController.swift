//
// Created by Timothy Shull on 7/9/16.
// Copyright (c) 2016 Timothy Shull. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    var r: Double = 0.0
    var g: Double = 0.0
    var b: Double = 0.0
    let a: Double = 1.0

    @IBOutlet weak var rSlider: NSSlider!
    @IBOutlet weak var gSlider: NSSlider!
    @IBOutlet weak var bSlider: NSSlider!

    @IBOutlet weak var colorWell: NSColorWell!

    override var windowNibName: String? {
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        rSlider.doubleValue = r
        gSlider.doubleValue = g
        bSlider.doubleValue = b
        updateColor()
    }

    func updateColor() {
        let newColor = NSColor(calibratedRed: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
        colorWell.color = newColor
    }

    @IBAction func adjustBlue(sender: NSSlider) {
        print("Blue value: \(sender.floatValue)")
        b = sender.doubleValue
        updateColor()
    }

    @IBAction func adjustGreen(sender: NSSlider) {
        print("Green value: \(sender.floatValue)")
        g = sender.doubleValue
        updateColor()
    }

    @IBAction func adjustRed(sender: NSSlider) {
        print("Red value: \(sender.floatValue)")
        r = sender.doubleValue
        updateColor()
    }
}
