//
// Created by Tim Shull on 9/17/16.
// Copyright (c) 2016 Tim Shull. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    override var windowNibName: String {
        return "MainWindowController"
    }

    // defaults
    let defaultNumberOfTicks = 0
    let maxTicks = 10
    let defaultSliderValue = 5.0
    let defaultLargeLabelValue = "Temp"
    let sliderActionLabels = [
            "up": "The slider's value increased",
            "down": "The slider's value decreased",
            "none": "The slider's value did not change"
    ]
    let checkBoxLabels = [
            "isChecked": "Uncheck me",
            "isUnchecked": "Check me"
    ]

    @IBOutlet var largeLabel: NSTextField!
    @IBOutlet var horizontalSlider: NSSlider!
    @IBOutlet var checkBox: NSButton!
    @IBOutlet var hiddenTextField: NSSecureTextField!
    @IBOutlet var revealedTextField: NSTextField!
    @IBOutlet var showTicksButtons: NSButton!
    @IBOutlet var hideTicksButtons: NSButton!

    var previousSliderValue: Double?

    init(_ coder: NSCoder? = nil) {
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init()
        }
        setDefaults()
    }

    required convenience init?(coder: NSCoder) {
        self.init(coder)
    }

    override init(window: NSWindow?) {
        super.init(window: window)
        setDefaults()
    }

    func setDefaults() {
        horizontalSlider?.doubleValue = defaultSliderValue
        previousSliderValue = defaultSliderValue
        checkBox?.title = checkBoxLabels["isChecked"]!
        checkBox?.state = 1
        largeLabel?.stringValue = ""
        hiddenTextField?.stringValue = ""
        revealedTextField?.stringValue = ""
        hideTicksButtons?.performClick(self)
    }

    @IBAction func horizontalSliderDidSlide(_ sender:NSSlider) {
        if let prevSliderVal = previousSliderValue {
            if sender.doubleValue > prevSliderVal {
                largeLabel.stringValue = sliderActionLabels["up"]!
            } else if sender.doubleValue < prevSliderVal {
                largeLabel.stringValue = sliderActionLabels["down"]!
            } else {
                largeLabel.stringValue = sliderActionLabels["none"]!
            }
        }
        previousSliderValue = sender.doubleValue
    }

    @IBAction func toggleTicks(_ sender:NSButton) {
        let id = sender.identifier!
        if id == "showTicksRadio" {
            horizontalSlider.numberOfTickMarks = maxTicks
        } else {
            horizontalSlider.numberOfTickMarks = defaultNumberOfTicks
        }
    }

    @IBAction func resetButtonWasClicked(_ sender:NSButton) {
        setDefaults()
    }

    @IBAction func checkBoxWasClicked(_ sender:NSButton) {
        if sender.state == 1 {
            sender.title = checkBoxLabels["isChecked"]!
        } else {
            sender.title = checkBoxLabels["isUnchecked"]!
        }
    }

    @IBAction func revealHiddenText(_ sender:NSButton) {
        revealedTextField.stringValue = hiddenTextField.stringValue
    }

}
