//
// Created by Tim Shull on 11/24/16.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

import Foundation


// ch1
func calculateWithDictionaries() {
    let prices = [
            "ACME": 45.23,
            "AAPL": 612.78,
            "IBM": 205.55,
            "HPQ": 37.20,
            "FB": 10.75
    ]

    let minPrice = prices.values.min()
    var minPriceTuple: (Double, String)? = nil
    for elem in zip(prices.values, prices.keys) {
        if elem.0 == minPrice {
            minPriceTuple = elem
        }
    }
    print("min price: (\(minPriceTuple!.0), '\(minPriceTuple!.1)')")

    let maxPrice = prices.values.max()
    var maxPriceTuple: (Double, String)? = nil
    for elem in zip(prices.values, prices.keys) {
        if elem.0 == maxPrice {
            maxPriceTuple = elem
        }
    }

    print("max price: (\(maxPriceTuple!.0), '\(maxPriceTuple!.1)')")

    let pricesSorted = zip(prices.values, prices.keys).sorted(by: { $0.0 < $1.0 })
    print("sorted prices: ")
    for elem in pricesSorted {
        print("    \(elem.1) \(elem.0)")
    }
}

// wordCounts[item] = (wordCounts[item] ?? 0) + 1
func determineTheTopNItemsOccurringInAList() {
    let words = [
            "look", "into", "my", "eyes", "look", "into", "my", "eyes",
            "the", "eyes", "the", "eyes", "the", "eyes", "not", "around", "the",
            "eyes", "don't", "look", "around", "the", "eyes", "look", "into",
            "my", "eyes", "you're", "under"
    ]

    var wordCounts: [String: Int] = [:]

    for item in words {
        if let val = wordCounts[item] {
            wordCounts[item] = val + 1
        } else {
            wordCounts[item] = 1
        }
    }

    var sortedWords = wordCounts.sorted {
        $0.1 > $1.1
    }

    for i in 0 ..< 3 {
        print("\(i == 0 ? "[" : "")('\(sortedWords[i].0)', \(sortedWords[i].1))\(i == 2 ? "]" : ", ")", terminator: "")
    }
    print()

    let moreWords = ["why", "are", "you", "not", "looking", "in", "my", "eyes"]

    for item in moreWords {
        if let val = wordCounts[item] {
            wordCounts[item] = val + 1
        } else {
            wordCounts[item] = 1
        }
    }

    sortedWords = wordCounts.sorted {
        $0.1 > $1.1
    }

    for i in 0 ..< 3 {
        print("\(i == 0 ? "[" : "")('\(sortedWords[i].0)', \(sortedWords[i].1))\(i == 2 ? "]" : ", ")", terminator: "")
    }
    print()
}

func extractASubsetOfADictionary() {
    let prices = [
            "ACME": 45.23,
            "AAPL": 612.78,
            "IBM": 205.55,
            "HPQ": 37.20,
            "FB": 10.75
    ]
    let p1 = prices.filter { $0.1 > 200 }
    print("All prices over $200: ")
    print("{", terminator: "")
    for elem in p1 {
        print("'\(elem.0)': \(String(format: "%.01f", elem.1)), ", terminator: "")
    }
    print("}")

    let techNames : Set = ["AAPL", "IBM", "HPQ", "MSFT"]
    let p2 = prices.filter { techNames.contains($0.0) }

    print("All tech stocks: ")
    print("{", terminator: "")
    for elem in p2 {
        print("'\(elem.0)': \(String(format: "%.01f", elem.1)), ", terminator: "")
    }
    print("}")
}


func filterListElements() {
    let list1 = [1, 4, -5, 10, -7, 2, 3, -1]

    let pos = list1.filter({ $0 > 0 })
    for elem in pos {
        print(elem)
    }

    print()
    let neg = list1.filter({ $0 < 0 })
    for elem in neg {
        print(elem)
    }

    print()
    let negClip = list1.map({ $0 < 0 ? $0 : 0 })
    for elem in negClip {
        print(elem)
    }

    print()
    let posClip = list1.map({ $0 > 0 ? $0 : 0 })
    for elem in posClip {
        print(elem)
    }

    let addresses = [
            "5412 N CLARK",
            "5148 N CLARK",
            "5800 E 58TH",
            "2122 N CLARK",
            "5645 N RAVENSWOOD",
            "1060 W ADDISON",
            "4801 N BROADWAY",
            "1039 W GRANVILLE"
    ]
    let counts = [0, 3, 10, 4, 1, 7, 6, 1]
    let a = zip(addresses, counts).filter({ $0.1 > 5 }).map({ $0.0 })
    for elem in a {
        print(elem)
    }
}
