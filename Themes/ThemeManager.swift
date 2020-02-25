//
//  ThemeManager.swift
//  fnet
//
//  Created by Eddie on 5/10/19.
//  Copyright © 2019 Eddie. All rights reserved.
//

import Foundation

import UIKit

/// Theme property protocol (Define which should use which). Becareful when make changes in this protocol.
protocol ThemeProp {

    static var mainColor: UIColor { get }

    // MARK: - NavBar
    /// Generated image from a color (use for gradient)
    static var navBarBgImage: UIImage? { get }
    static var navBarBgColor: UIColor? { get }
    static var navBarTintColor: UIColor? { get }

    // Mark: - Tabbar
    static var tabBarBgColor: UIColor? { get }
    static var tabBarTintColor: UIColor? { get }

    // Common button
    /// For acceptance button like OK, accept, done...
    static var primaryBtnColor: UIColor? { get }

    /// For denial button like cancel, back...
    static var secondaryBtnColor: UIColor? { get }

    /// For destructive button like delete, cancel, remove...
    static var destructiveBtnColor: UIColor? { get }

    /// For tabs or segments
    static var activeBtnColor: UIColor? { get }
    /// For tabs or segments
    static var inactiveBtnColor: UIColor? { get }
}
extension ThemeProp {
    fileprivate static var navigationHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height + 44 // 44 is default navigation height.
    }
}

// Consider to move these things to a different file (E.g. ThemeConfig) for configuration only.
private struct BlueThemeProp: ThemeProp {

    static var mainColor: UIColor = UIColor(rgb: 0x08324A)

    static var navBarBgImage: UIImage? = {
        // Temporary using raw color instead of gradient
        return nil
//        // We might consider apply this as a common later
//        let gradient = CAGradientLayer()
//        let sizeLength = UIScreen.main.bounds.size.height * 2
//
//        let defaultNavigationBarFrame = CGRect(x: 0, y: 0, width: sizeLength, height: navigationHeight)
//        gradient.frame = defaultNavigationBarFrame
//        gradient.colors = [UIColor(rgb: 0xF58E4F).cgColor, UIColor(rgb: 0xF2A42C).cgColor]
//
//        // Create bg image from gradient color
//        UIGraphicsBeginImageContext(gradient.frame.size)
//        gradient.render(in: UIGraphicsGetCurrentContext()!)
//        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return outputImage
    }()

    static var navBarBgColor: UIColor? = mainColor
    static var navBarTintColor: UIColor? = UIColor.white

    static var tabBarBgColor: UIColor? = mainColor
    static var tabBarTintColor: UIColor? = navBarTintColor

    static var primaryBtnColor: UIColor? = UIColor(rgb: 0x2E83A2)
    static var secondaryBtnColor: UIColor? = UIColor(rgb: 0xE4E4E4)
    static var destructiveBtnColor: UIColor? = nil

    static var activeBtnColor: UIColor? = UIColor(rgb: 0xF5F5F5)
    static var inactiveBtnColor: UIColor? = secondaryBtnColor
}

typealias ThemeStyle = ThemeManager.Style
struct ThemeManager {

    /// Theme enum
    enum Style {
        case `default`

        /// Get theme properties
        fileprivate var props: ThemeProp.Type {
            return BlueThemeProp.self
//            switch self {
//            default: return BlueThemeProp.self
//            }
        }
    }

    //    static var shared = SCThemeManager()
    private(set) static var currentTheme = ThemeStyle.default
    static var currentProps: ThemeProp.Type { return currentTheme.props }

    // Private init. Use sharedInstance only (not implement yet, because we only have 1 theme now)
    private init() {}

    static func applyTheme(_ theme: ThemeStyle) {
        let themeProp = theme.props

        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.barTintColor = themeProp.navBarBgColor
        navBarAppearance.setBackgroundImage(themeProp.navBarBgImage, for: .default)
        navBarAppearance.isTranslucent = false

        let toolbarAppearance = UIToolbar.appearance()
        toolbarAppearance.barTintColor = themeProp.navBarBgColor
        toolbarAppearance.tintColor = themeProp.navBarTintColor

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes
            = [NSAttributedString.Key.foregroundColor: themeProp.navBarTintColor as Any]

        if let navBarTintColor = themeProp.navBarTintColor {
            navBarAppearance.titleTextAttributes = [.foregroundColor: navBarTintColor]

            let navBarItemAppearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
            navBarItemAppearance.setTitleTextAttributes([.foregroundColor: navBarTintColor], for: .normal)
            navBarItemAppearance.tintColor = navBarTintColor
        }

        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.barTintColor = themeProp.tabBarBgColor
        tabBarAppearance.tintColor = themeProp.tabBarTintColor
        tabBarAppearance.unselectedItemTintColor = themeProp.tabBarTintColor

        let pageControlAppearance = UIPageControl.appearance()
        pageControlAppearance.currentPageIndicatorTintColor = themeProp.primaryBtnColor
        pageControlAppearance.tintColor = themeProp.secondaryBtnColor

        let switchControlAppearance = UISwitch.appearance()
        switchControlAppearance.onTintColor = themeProp.primaryBtnColor
        switchControlAppearance.thumbTintColor = themeProp.secondaryBtnColor

        UIImageView.appearance().tintColor = themeProp.mainColor

//        UIButton.appearance(whenContainedInInstancesOf: [HomeVC.self]).tintColor
//        UIButton.appearance().tintColor = themeProp.btnTintColor
        UIFont.overrideInitialize()

        // Fix scrollView bug in iOS 11.0 & 11.1
        // Reference: https://stackoverflow.com/a/45578760/1696598
        if #available(iOS 11.0, *) {
            if #available(*, iOS 11.2) {} // Do nothing (as we need specific in range of 11.0 ..< 11.2)
            else {
                UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
            }
        }
    }
}

