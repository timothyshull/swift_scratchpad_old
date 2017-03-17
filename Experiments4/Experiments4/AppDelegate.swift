import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var mainWindowController: MainWindowController?
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        mainWindowController = MainWindowController()
        mainWindowController!.showWindow(self)
    }
    
    func applicationWillTerminate(aNotification: NSNotification) { }
}
