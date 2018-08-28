//
//  UIColor+Hex.swift
//  EDSwiftCore
//
//  Created by Eddie Luke Atmey on 08/28/18.
//

import Foundation

public extension UIColor {

    convenience init(r: Int, g: Int, b: Int, a: Float = 1) {

        let color: ((Int) -> CGFloat) = { color in
            var c = color
            if color < 0 { c = 0 }
            else if color > 255 { c = 255 }

            return CGFloat(c)
        }

        let alpha: CGFloat = {
            if a > 1 { return 1.0 }
            else if a < 0 { return 0.0 }
            return CGFloat(a)
        }()

        self.init(red: color(r) / 255.0, green: color(g) / 255.0, blue: color(b) / 255.0, alpha: alpha)
    }

    /// Init with hex (alpha = 1)
    /// - parameter rgb: format as 0x00FFBB
    convenience init(rgb: Int) {
        let hex = rgb > 0xFFFFFF ? 0xFFFFFF : rgb
        self.init(aRgb: 0xFF000000 | hex)
    }

    /// Init with hex (+ alpha)
    /// - parameter aRgb: format as 0xAA00FFBB (alpha will be / 255, R, G, B)
    convenience init(aRgb: Int) {
        self.init(r: (aRgb >> 16) & 0xff,
                  g: (aRgb >> 8) & 0xff,
                  b: aRgb & 0xff,
                  a: Float((aRgb >> 24) & 0xff) / 255.0)
    }
}
