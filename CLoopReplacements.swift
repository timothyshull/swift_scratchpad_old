import Foundation

// LOOPING N TIMES
/* 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 */

// Instead of this:
//for var i = 0; i < 10; i++ {
//    print(i)
//}

// use this:
for i in 0..<10 {
    print(i)
}

// LOOPING N TIMES IN REVERSE
/* 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 */

// instead of this
//for var i = 10; i > 0; i-- {
//    print(i)
//}

// use this
for i in (1...10).reversed() {
    print(i)
}

// LOOPING WITH STRIDE
/* 0, 2, 4, 6, 8 */

// instead of this
//for var i = 0; i < 10; i += 2 {
//    print(i)
//}

// use this
for i in stride(from: 0, to: 10, by: 2) {
    print(i)
}

// LOOPING THROUGH ARRAY VALUES
var someNumbers = [2, 3, 45, 6, 8, 83, 100]

/* 2, 3, 45, 6, 8, 83, 100 */

// instead of this
//for var i = 0; i < someNumbers.count; i++ {
//    print(someNumbers[i])
//}

// use this
for number in someNumbers {
    print(number)
}

// or this
someNumbers.forEach {
    number in
    print(number)
}


// REVERSE LOOPING THROUGH ARRAY VALUES
someNumbers = [2, 3, 45, 6, 8, 83, 100]

/* 100, 83, 8, 6, 45, 3, 2 */

// instead of this
//for var i = someNumbers.count - 1; i >= 0; i-- {
//    print(someNumbers[i])
//}

// use this
for number in someNumbers.reversed() {
    print(number)
}


// LOOPING THROUGH ARRAY WITH INDICES
someNumbers = [2, 3, 45, 6, 8, 83, 100]

/*
 1: 2
 2: 3
 3: 45
 4: 6
 5: 8
 6: 83
 7: 100
 */

// instead of this
//for var i = 0; i < someNumbers.count; i++ {
//    print("\(i + 1): \(someNumbers[i])")
//}

// use this
for (index, number) in someNumbers.enumerated() {
    print("\(index + 1): \(number)")
}

// or this
someNumbers.enumerated().forEach { (index, number) in
    print("\(index + 1): \(number)")
}


// LOOPING THROUGH ARRAY WITH INDICES
someNumbers = [2, 3, 45, 6, 8, 83, 100]

/* 0, 1, 2, 3, 4, 5, 6 */

// instead of this
//for var i = 0; i < someNumbers.count; i++ {
//    print(i)
//}

// use this
for index in someNumbers.indices {
    print(index)
}
