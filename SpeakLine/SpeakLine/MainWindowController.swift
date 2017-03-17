//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by Tim Shull on 9/20/16.
//  Copyright © 2016 Tim Shull. All rights reserved.
//

import Cocoa



class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate, NSWindowDelegate, NSTableViewDataSource, NSTableViewDelegate {
    
    override var windowNibName: String {
        return "MainWindowController"
    }
    
    
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    let speechSynth: NSSpeechSynthesizer = NSSpeechSynthesizer()
    
    let voices = NSSpeechSynthesizer.availableVoices()
    
    var isStarted: Bool = false {
        didSet {
            updateButtons()
        }
    }
    
    
    override func windowDidLoad() {
        super.windowDidLoad()
        updateButtons()
        speechSynth.delegate = self
        let defaultVoice = NSSpeechSynthesizer.defaultVoice()
        if let defaultRow = voices.index(of: defaultVoice) {
            let indices = NSIndexSet(index: defaultRow)
            tableView.selectRowIndexes(indices as IndexSet, byExtendingSelection: false)
            tableView.scrollRowToVisible(defaultRow)
        }
    }
    
    
    // MARK: Action methods
    @IBAction func speakIt(sender: NSButton) {
        
        // Get typed-in text as a string
        let string = textField.stringValue
        if string.isEmpty {
            print("string from \(textField) is empty")
        } else {
            speechSynth.startSpeaking(string)
            isStarted = true
        }
    }
    
    
    @IBAction func stopIt(sender: NSButton) {
        speechSynth.stopSpeaking()
        //isStarted = false
    }
    
    
    func updateButtons() {
        if isStarted {
            speakButton.isEnabled = false
            stopButton.isEnabled = true
        } else {
            stopButton.isEnabled = false
            speakButton.isEnabled = true
        }
    }
    
    func voiceNameForIdentifier(identifier: String) -> String? {
        let attributes = NSSpeechSynthesizer.attributes(forVoice: identifier)
        return attributes[NSVoiceName] as? String
    }
    
    
    // MARK: NSSpeechSynthesizerDelegate
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        isStarted = false
        print("finishedSpeaking=\(finishedSpeaking)")
    }
    
    
    // MARK: NSWindowDelegate
    private func windowShouldClose(sender: AnyObject) -> Bool {
        return !isStarted
    }
    
    
    // MARK: NSTableViewDataSource
    internal func numberOfRows(in tableView: NSTableView) -> Int {
        return voices.count
    }
    
    public func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        let voice = voices[row]
        let voiceName = voiceNameForIdentifier(identifier: voice)
        return voiceName as Any?
    }
    
    
    // MARK: NSTableViewDelegate
    func tableViewSelectionDidChange(_ notification: Notification) {
        let row = tableView.selectedRow
        
        // Set the voice back to the default if the user has deselected all rows
        if row == -1 {
            speechSynth.setVoice(nil)
            return
        }
        let voice = voices[row]
        speechSynth.setVoice(voice)
    }
    
}


