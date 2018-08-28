//
//  Array+Helpers.swift
//  EDSwiftCore
//
//  Created by Eddie Luke Atmey on 08/28/18.
//

import Foundation

public extension Array where Element: Equatable {

    /// Only remove once if found.
    /// - parameter obj: object to remove
    /// - returns: removed object or nil if not found.
    mutating func es_remove(_ obj: Element) -> Element? {
        guard let index = index(of: obj) else { return nil }
        return remove(at: index)
    }

    /// Only remove multiple object once if found.
    /// - parameter obj: object to remove
    /// - returns: removed object or nil if not found.
    mutating func es_remove(_ objs: Element...) -> [Element] {

        var result = [Element]()
        objs.forEach { if let obj = es_remove($0) { result.append(obj) } }
        return result
    }

    mutating func es_removeAll(_ obj: Element) -> Element? {
        guard let index = index(of: obj) else { return nil }
        let removed = remove(at: index)
        return es_removeAll(obj) ?? removed
    }
}
