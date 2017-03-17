//
//  MainWindowController.swift
//  TodoList
//
//  Created by Tim Shull on 9/20/16.
//  Copyright © 2016 Tim Shull. All rights reserved.
//

import Cocoa


class MainWindowController: NSWindowController, NSWindowDelegate, NSTableViewDataSource {
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    @IBOutlet weak var textInput: NSTextField!
    @IBOutlet weak var addButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    var todoList: [String] = []
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @IBAction func addTodo(_ sender: NSButton) {
        todoList.append(textInput.stringValue)
        tableView.reloadData()
        textInput.stringValue = ""
    }
    
    // MARK: NSTableViewDataSource
    internal func numberOfRows(in tableView: NSTableView) -> Int {
        return todoList.count
    }
    
    public func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return todoList[row] as Any?
    }
}
