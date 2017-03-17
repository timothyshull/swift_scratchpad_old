import Cocoa

class MainWindowController: NSWindowController {
    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @IBAction func testIBAction(sender: NSButton) {
        
    }
    
}
