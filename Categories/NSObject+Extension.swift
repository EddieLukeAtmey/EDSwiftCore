//
//  NSObject+Extension.swift
//  fnet
//
//  Created by Eddie on 5/2/19.
//  Copyright © 2019 Eddie. All rights reserved.
//

import Foundation

extension NSObject {

    class var className: String { return String(describing: self) }
    var className: String { return ClassName(of: self) }
}

/// for non-object:
func ClassName(of object: Any) -> String {
    return String(describing: type(of: object))
}
