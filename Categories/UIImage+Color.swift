//
//  UIImage+Color.swift
//  fnet
//
//  Created by Eddie on 5/17/19.
//  Copyright © 2019 Eddie. All rights reserved.
//

import UIKit

extension UIColor {
    func image(size: CGSize = CGSize(width: 120, height: 120)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
