//
//  String+l10n.swift
//  EDSwiftCore
//
//  Created by Eddie on 2/25/20.
//

import Foundation

protocol Localizable {
    /// Default extension for enum string: ClassName + "." + value
    var l10n: String { get }
}

// Discussion: Consider this extension (see ReaderBooking.FormattedText)
//extension Localizable {
//    func f_l10n(_ f: CVarArg...) -> String { return String(format: l10n, locale: .current, arguments: f) }
//}

extension String: Localizable {
    var l10n: String { return NSLocalizedString(self, comment: self) }
    func f_l10n(_ f: CVarArg...) -> String { return String(format: l10n, locale: .current, arguments: f) }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var l10n: String { return (ClassName(of: self) + "." + rawValue).l10n }
}
