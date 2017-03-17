//
// Created by Tim Shull on 9/11/16.
// Copyright (c) 2016 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

let MAX_CHILDREN: Int = 4;

enum BTreeError: ErrorType {
    case BTreeStandardError(error:String)
}

class Node<Key, Value where Key:Comparable, Key:Equatable> {
    private var m: Int;
    private var children: Array<Entry<Key, Value>?> = [Entry<Key, Value>?](count: MAX_CHILDREN, repeatedValue: nil);

    // create a node with k children
    init(k: Int) {
        m = k;
    }
}

class Entry<Key, Value where Key:Comparable, Key:Equatable>  {
    private var key: Key;
    private var val: Value;
    private var next: Node<Key, Value>;

    init(key: Key, val: Value, next: Node<Key, Value>?) {
        self.key = key;
        self.val = val;
        self.next = next!;
    }
}

class BTree<Key, Value where Key:Comparable, Key:Equatable>  {
    typealias NodeType = Node<Key, Value>;
    typealias EntryType = Entry<Key, Value>;
    typealias OptionalNodeType = Node<Key, Value>?;
    typealias OptionalEntryType = Entry<Key, Value>?;

    private var M: Int = 4;

    private var _root: OptionalNodeType;
    private var _height: Int;
    private var _n: Int;

    init() {
        _root = Node(k: 0);
    }

    func isEmpty() -> Bool {
        return size() == 0;
    }

    func size() -> Int {
        return _n;
    }

    func height() -> Int {
        return _height;
    }

    func get(key: Key?) throws -> Value? {
        if (key == nil) {
            // NullPointerException
            throw BTreeError.BTreeStandardError(error: "key must not be null");
        }
        return search(_root!, key: key!, ht: _height);
    }

    func search(x: OptionalNodeType, key: Key, ht: Int) -> Value? {
        var children: Array<OptionalEntryType> = x!.children;

        if (ht == 0) {
            for j in 0 ..< x!.m {
                if key == children[j]!.key {
                    return children[j]!.val;
                }
            }
        } else {
            for j in 0 ..< x!.m {
                if j + 1 == x!.m || key < children[j + 1]!.key {
                    return search(children[j]!.next, key: key, ht: ht - 1);
                }
            }
        }
        //    return nil;
    }

    func put(key: Key, val: Value) throws -> Void {
//        if key == nil {
//            //        NullPointerException("key must not be null");
//            throw BTreeError.BTreeStandardError(error: "key must not be null");
//        }
        if var u = insert(_root, key: key, val: val, ht: _height) {
            _n += 1;
            // need to split root
            var t: NodeType = Node(k: 2);
            t.children[0] = OptionalEntryType(key: _root!.children[0]!.key, val: nil, next: _root);
            t.children[1] = OptionalEntryType(key: u!.children[0]!.key, val: nil, next: u);
            _root = t;
            _height += 1;
        }
    }

    func insert(h: NodeType, key: Key, val: Value, ht: Int) -> OptionalNodeType {
        let j: Int;
        let t: EntryType = Entry(key: key, val: val, next: nil);

        // external node
        if ht == 0 {
            for j in 0 ..< h.m {
                if key < h.children[j]!.key {
                    break;
                }
            }
        } else {
            for j in 0 ..< h.m {
                if j + 1 == h.m || key < h.children[j + 1]!.key {
                    let u: OptionalNodeType = insert(h.children[j + 1]!.next, key: key, val: val, ht: ht - 1);
                    if u == nil {
                        return nil;
                    }
                    t.key = u!.children[0]!.key;
                    t.next = u!;
                    break;
                }
            }
        }

        for i in h.m.stride(through: j, by: -1) {
            h.children[i] = h.children[i - 1];
        }

        h.children[j] = t;
        h.m += 1;

        if h.m < M {
            return nil;
        } else {
            return split(h);
        }
    }

    func split(h: NodeType) -> NodeType {
        let t: NodeType = Node(k: MAX_CHILDREN / 2);
        h.m = (MAX_CHILDREN / 2);
        for j in 0 ..< (MAX_CHILDREN / 2) {
            t.children[j] = h.children[MAX_CHILDREN / 2 + j];
        }
        return t;
    }

    func toString() -> String {
        return toString(_root!, ht: _height, indent: "") + "\n";
    }

    func toString(h: NodeType, ht: Int, indent: String) -> String {
        var s: String = "";
        var children: Array<OptionalEntryType> = h.children;

        if (ht == 0) {
            for j in 0 ..< h.m {
                s += indent + children[j]!.key + " " + children[j].val + "\n";
            }
        } else {
            for j in 0 ..< h.m {
                if j > 0 {
                    s += indent + "(" + children[j]!.key + ")\n";
                }
                s += toString(children[j]!.next, ht: ht - 1, indent: indent + "     ");
            }
        }
        return s;
    }


// comparison functions - make Comparable instead of Key to avoid casts
//private boolean less(Comparable k1, Comparable k2) {
//    return k1.compareTo(k2) < 0;
//}
//
//private boolean eq(Comparable k1, Comparable k2) {
//    return k1.compareTo(k2) == 0;
//}

}