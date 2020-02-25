//
//  Decimal+Conversion.swift
//  fnet
//
//  Created by Eddie on 5/23/19.
//  Copyright © 2019 Eddie. All rights reserved.
//

import Foundation

extension Decimal {

    /// Bridge back to NSDecimalNumber.
    var dcmn: NSDecimalNumber { return self as NSDecimalNumber }

    func rounding(scale: Int16 = 0, mode: RoundingMode = .plain) -> Decimal {
        let rounding = NSDecimalNumberHandler(roundingMode: mode, scale: scale, raiseOnExactness: false,
                                              raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return dcmn.rounding(accordingToBehavior: rounding).decimalValue
    }
}
