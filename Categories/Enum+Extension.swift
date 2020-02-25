//
//  Enum+Extension.swift
//  fnet
//
//  Created by mac on 10/22/19.
//  Copyright © 2019 Eddie. All rights reserved.
//

import Foundation

extension CaseIterable where Self: RawRepresentable, Self: Equatable {

    /// Default by order
    var intValue: Int {
        return (Self.allCases.firstIndex(where: { $0 == self }) as? Int) ?? 0
    }
}
