import UIKit

class Student: NSObject {
    var name = ""
    var gradeLevel = 0
}

let s = Student()
s.setValue("Kelly", forKey: "name")
s.setValue(3, forKey: "gradeLevel")
s.value(forKey: "name")
s.value(forKey: "gradeLevel")
