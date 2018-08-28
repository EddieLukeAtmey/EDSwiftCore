//
//  UIView+IBHelper.swift
//  EDSwiftCore
//
//  Created by Eddie Luke Atmey on 08/28/18.
//

import Foundation

public extension UIView {

    @IBInspectable var es_borderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else { return nil }
            return UIColor(cgColor:  borderColor)
        }
        set { self.layer.borderColor = newValue?.cgColor }
    }

    @IBInspectable var es_borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable var es_cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

    @IBInspectable var es_masksToBounds: Bool {
        get { return layer.masksToBounds }
        set { layer.masksToBounds = newValue }
    }

    func es_makeFullConstriaintParent() {
        guard let parrentView = self.superview else { return }
        let dict = ["view":self]
        self.translatesAutoresizingMaskIntoConstraints = false
        parrentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        parrentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
    }
}
