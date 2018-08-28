//
//  String+Helpers.swift
//  EDSwiftCore
//
//  Created by Eddie Luke Atmey on 08/28/18.
//

import Foundation

private enum CommonRegex: String {

    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    case webURL = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
}

public extension String {

    /// - returns localized String, receiver act as key.
    func es_l10n(_ comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }

    /// Manipulation
    var es_trimWhiteSpace: String { return trimmingCharacters(in: .whitespacesAndNewlines) }

    // MARK: - Validation
    var es_isEmpty: Bool { return es_trimWhiteSpace.count == 0 }

    /// Reverse of isEmpty
    var es_hasData: Bool { return !es_isEmpty }

    /// Validate email with regex: [A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}
    var esEmail: Bool { return es_isValidWithRegex(CommonRegex.email.rawValue) }

    /// Validate web url with regex: (http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+
    var esWebURL: Bool { return es_isValidWithRegex(CommonRegex.webURL.rawValue) }

    /// SubString with regex.
    func es_matches(regex: String) -> [String] {

        guard let regex = try? NSRegularExpression(pattern: regex) else { return [] }

        let nsString = self as NSString
        let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
        return results.map { nsString.substring(with: $0.range)}
    }

    /// Check if valid with passing regex.
    func es_isValidWithRegex(_ regex: String) -> Bool {

        guard let regex = try? NSRegularExpression(pattern: regex) else { return false }

        return regex.numberOfMatches(in: self,
                                     options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                     range: NSMakeRange(0, count)) > 0
    }

    // MARK: Converter
    func es_dateWithFormat(_ format: String, locale: Locale = .current, timeZone: TimeZone = .current, cal: Calendar = .current) -> Date? {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.calendar = cal
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        return dateFormatter.date(from: self)
    }

}
