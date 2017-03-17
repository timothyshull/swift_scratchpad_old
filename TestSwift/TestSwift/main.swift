//
//  main.swift
//  TestSwift
//
//  Created by Tim Shull on 9/11/16.
//  Copyright (c) 2016 Tim Shull. All rights reserved.
//

import Foundation


let st: BTree<String, String> = BTree<String, String>();
do {
    try st.put("www.cs.princeton.edu", val: "128.112.136.12");
    try st.put("www.cs.princeton.edu", val: "128.112.136.11");
    try st.put("www.princeton.edu", val: "128.112.128.15");
    try st.put("www.yale.edu", val: "130.132.143.21");
    try st.put("www.simpsons.com", val: "209.052.165.60");
    try st.put("www.apple.com", val: "17.112.152.32");
    try st.put("www.amazon.com", val: "207.171.182.16");
    try st.put("www.ebay.com", val: "66.135.192.87");
    try st.put("www.cnn.com", val: "64.236.16.20");
    try st.put("www.google.com", val: "216.239.41.99");
    try st.put("www.nytimes.com", val: "199.239.136.200");
    try st.put("www.microsoft.com", val: "207.126.99.140");
    try st.put("www.dell.com", val: "143.166.224.230");
    try st.put("www.slashdot.org", val: "66.35.250.151");
    try st.put("www.espn.com", val: "199.181.135.201");
    try st.put("www.weather.com", val: "63.111.66.11");
    try st.put("www.yahoo.com", val: "216.109.118.65");
} catch {
    print("An error occurred while \"putting\" values into the BTree");
}

do {
    try print("cs.princeton.edu:  " + st.get("www.cs.princeton.edu")!);
    try print("hardvardsucks.com: " + st.get("www.harvardsucks.com")!);
    try print("simpsons.com:      " + st.get("www.simpsons.com")!);
    try print("apple.com:         " + st.get("www.apple.com")!);
    try print("ebay.com:          " + st.get("www.ebay.com")!);
    try print("dell.com:          " + st.get("www.dell.com")!);
} catch {
    print("An error occurred while printing characteristics of the BTree");
}

print("", terminator: "");
print("size:    " + String(st.size()));
print("height:  " + String(st.height()));
print(st, terminator: "");
print("", terminator: "");