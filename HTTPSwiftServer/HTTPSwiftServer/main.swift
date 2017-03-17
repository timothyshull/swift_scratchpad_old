import Foundation

struct SomeRespondableDelegate: Respondable {}

let server = HTTPServer.sharedInstance
server.delegate = SomeRespondableDelegate()
server.start()
NSRunLoop.mainRunLoop().run()