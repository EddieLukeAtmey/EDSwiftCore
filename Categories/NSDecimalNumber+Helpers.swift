//
//  NSDecimalNumber+Helpers.swift
//  EDSwiftCore
//
//  Created by Eddie Luke Atmey on 08/28/18.
//

import Foundation

public extension NSDecimalNumber {

    class func es_decimalNumber(with anotherNumber: NSNumber) -> NSDecimalNumber {
        return NSDecimalNumber(decimal: anotherNumber.decimalValue)
    }

    func es_absoluteValue() -> NSDecimalNumber {
        if self.es_isSmallerThan(NSDecimalNumber.zero) {
            return multiplying(by: NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: true))
        }
        return self
    }

    func es_isGreaterThan(_ anotherNumber: NSNumber) -> Bool {
        return self.compare(anotherNumber) == .orderedDescending
    }

    func es_isEqual(to anotherNumber: NSNumber) -> Bool {
        return self.compare(anotherNumber) == .orderedSame
    }

    func es_isSmallerThan(_ anotherNumber: NSNumber) -> Bool {
        return self.compare(anotherNumber) == .orderedAscending
    }

    static func >  (left: NSDecimalNumber, right: NSDecimalNumber) -> Bool { return left.es_isGreaterThan(right) }
    static func >= (left: NSDecimalNumber, right: NSDecimalNumber) -> Bool { return !left.es_isSmallerThan(right) }
    static func <  (left: NSDecimalNumber, right: NSDecimalNumber) -> Bool { return left.es_isSmallerThan(right) }
    static func <= (left: NSDecimalNumber, right: NSDecimalNumber) -> Bool { return !left.es_isGreaterThan(right) }

    // Non-Opt
    static func + (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber { return left.adding(right) }
    static func - (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber { return left.subtracting(right) }
    static func * (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber { return left.multiplying(by: right) }
    static func / (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber { return left.dividing(by: right) }

    static func += (left: inout NSDecimalNumber, right: NSDecimalNumber) { left = left + right }
    static func -= (left: inout NSDecimalNumber, right: NSDecimalNumber) { left = left - right }
    static func *= (left: inout NSDecimalNumber, right: NSDecimalNumber) { left = left * right }
    static func /= (left: inout NSDecimalNumber, right: NSDecimalNumber) { left = left / right }

    // Optional
    static func + (left: NSDecimalNumber?, right: NSDecimalNumber) -> NSDecimalNumber? { return left?.adding(right) }
    static func - (left: NSDecimalNumber?, right: NSDecimalNumber) -> NSDecimalNumber? { return left?.subtracting(right) }
    static func * (left: NSDecimalNumber?, right: NSDecimalNumber) -> NSDecimalNumber? { return left?.multiplying(by: right) }
    static func / (left: NSDecimalNumber?, right: NSDecimalNumber) -> NSDecimalNumber? { return left?.dividing(by: right) }

    static func += (left: inout NSDecimalNumber?, right: NSDecimalNumber) { left = left + right }
    static func -= (left: inout NSDecimalNumber?, right: NSDecimalNumber) { left = left - right }
    static func *= (left: inout NSDecimalNumber?, right: NSDecimalNumber) { left = left * right }
    static func /= (left: inout NSDecimalNumber?, right: NSDecimalNumber) { left = left / right }
}

public extension BinaryFloatingPoint {
    var es_dcmn: NSDecimalNumber {
        let dcm = NSDecimalNumber(string: String(stringInterpolationSegment: self))
        return dcm == .notANumber ? .zero : dcm
    }
}

public extension BinaryInteger {
    var es_dcmn: NSDecimalNumber {
        let dcm = NSDecimalNumber(string: String(stringInterpolationSegment: self))
        return dcm == .notANumber ? .zero : dcm
    }
}
