//
// Created by Timothy Shull on 7/8/16.
// Copyright (c) 2016 Timothy Shull. All rights reserved.
//

import Foundation
import AppKit

class MainWindowController: NSWindowController {
    @IBOutlet weak var textField: NSTextField!

    var player: CustomSineWavePlayer?

    override  var windowNibName: String {
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        self.player = CustomSineWavePlayer()
    }

    func playSineWave() {
        // set up unit and callback
        createAndConnectOutputUnit(&player!)

        // start playing
        checkError(AudioOutputUnitStart(player!.outputUnit), "Couldn't start output unit")

        print("playing\n")
        // play for 5 seconds
        sleep(5)
        AudioOutputUnitStop(player!.outputUnit)
        AudioUnitUninitialize(player!.outputUnit)
        AudioComponentInstanceDispose(player!.outputUnit)
    }

    @IBAction func setFrequency(sender: NSTextField) {
        let mirrored_object = Mirror(reflecting: textField)

        for (index, attr) in mirrored_object.children.enumerate() {
            if let property_name = attr.label as String! {
                print("Attr \(index): \(property_name) = \(attr.value)")
            }
        }
    }
}
