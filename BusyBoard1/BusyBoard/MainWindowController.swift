//
//  MainWindowController.swift
//  BusyBoard
//
//  Created by Timothy Shull on 7/9/16.
//  Copyright © 2016 Timothy Shull. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    @IBOutlet weak var slider: NSSlider!
    @IBOutlet weak var textBox: NSTextField!
    @IBOutlet weak var checkBoxLabel: NSButtonCell!
    @IBOutlet weak var checkBox: NSButton!
    @IBOutlet weak var sliderLabel: NSTextField!
    @IBOutlet weak var secureTextField: NSSecureTextField!
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var showTickRadio: NSButton!
    @IBOutlet weak var hideTickRadio: NSButton!

    var sliderVal: Double = 0.0

    override var windowNibName: String {
        return "MainWindowController"
    }

    @IBAction func resetControls(sender: NSButton) {
        slider.doubleValue = 0.0
        sliderLabel.stringValue = "";
        textField.stringValue = ""
        secureTextField.stringValue = ""
        showTickRadio.state = NSOnState
        hideTickRadio.state = NSOffState
        slider.numberOfTickMarks = 10
        checkBox.state = 1
        checkBoxLabel.title = "Uncheck"
    }

    @IBAction func setCurrentSliderLabel(sender: NSSlider) {
        if sender.doubleValue < sliderVal {
            sliderLabel.stringValue = "Value decreased"
        } else if sender.doubleValue > sliderVal {
            sliderLabel.stringValue = "Value increased"
        } else {
            sliderLabel.stringValue = "Value unchanged"
        }
        sliderVal = sender.doubleValue
    }

    @IBAction func toggleSliderTickMarks(sender: NSButton) {
        if sender.tag == 1 {
            slider.numberOfTickMarks = 10
        } else {
            slider.numberOfTickMarks = 0
        }
    }

    @IBAction func handleCheckboxToggle(sender: NSButton) {
        if sender.state == 1 {
            checkBoxLabel.title = "Uncheck"
        } else {
            checkBoxLabel.title = "Check"
        }
        print("\(sender.state)")
    }

    @IBAction func revealSecureTextField(sender: NSButton) {
        textField.stringValue = secureTextField.stringValue
    }
}
