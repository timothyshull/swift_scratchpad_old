//
//  Document.swift
//  RaiseMan
//
//  Created by Tim Shull on 9/21/16.
//  Copyright © 2016 Tim Shull. All rights reserved.
//

import Cocoa

private var kvoContext: Int = 0

class Document: NSDocument, NSWindowDelegate {
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var arrayController: NSArrayController!
    
    var employees: [Employee] = [] {
        willSet {
            for employee in employees {
                stopObserving(employee: employee)
            }
        }
        didSet {
            for employee in employees {
                startObserving(employee: employee)
            }
        }
    }
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override var windowNibName: String? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return "Document"
    }
    
    // MARK: NSWindowDelegate
    func windowWillClose(_ notification: Notification) {
        employees = []
    }

    override func data(ofType typeName: String) throws -> Data {
//        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        return Data()
    }

    override func read(from data: Data, ofType typeName: String) throws {
//        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }
    
    // MARK: Actions
    @IBAction func addEmployee(sender: NSButton) {
        
    }
    
    // MARK: Accessors
    func insertObject(employee: Employee, inEmployeesAtIndex index: Int) {
        Swift.print("Adding \(employee) to the employees array")
        let undo: UndoManager = undoManager!
        (undo.prepare(withInvocationTarget: self) as! Document).removeObjectFromEmployeesAtIndex(index: employees.count)
        if !undo.isUndoing {
            undo.setActionName("Add employee")
        }
    }
    
    func removeObjectFromEmployeesAtIndex(index: Int) {
        let employee: Employee = employees[index]
        
        Swift.print("Removing \(employee) from the employees array")
        
        let undo: UndoManager = undoManager!
        (undo.prepare(withInvocationTarget: self) as! Document).insertObject(employee: employee, inEmployeesAtIndex: index)
        if !undo.isUndoing {
            undo.setActionName("Remove employee")
        }
    }
    
    // MARK: Key-Value Observing
    func startObserving(employee: Employee) {
        employee.addObserver(self, forKeyPath: "name", options: .old, context: &kvoContext)
        employee.addObserver(self, forKeyPath: "raise", options: .old, context: &kvoContext)
    }
    
    func stopObserving(employee: Employee) {
        employee.removeObserver(self, forKeyPath: "name", context: &kvoContext)
        employee.removeObserver(self, forKeyPath: "raise", context: &kvoContext)
    }
    
    override func observeValue(forKeyPath: String?, of: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if context != &kvoContext {
            super.observeValue(forKeyPath: forKeyPath, of: of, change: change, context: context)
            return
        }
        
        var tmp: Any? = change?[NSKeyValueChangeKey.oldKey]
        if tmp is NSNull {
            tmp = nil
        }
        
        let undo: UndoManager = undoManager!
        Swift.print("previous value=\(tmp)")
        (undo.prepare(withInvocationTarget: of) as AnyObject).setValue(tmp, forKey: forKeyPath!)
    }

}

