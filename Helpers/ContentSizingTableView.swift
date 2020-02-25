//
//  ContentSizingTableView.swift
//  fnet
//
//  Created by mac on 10/8/19.
//  Copyright © 2019 Eddie. All rights reserved.
//

import UIKit

// Help from https://stackoverflow.com/a/48623673
final class ContentSizingTableView: UITableView {
    override var contentSize:CGSize { didSet { invalidateIntrinsicContentSize() }}

    /// - Note: You should see some errors, because Storyboard doesn't take our subclass' `intrinsicContentSize` into account.
    /// Fix this by opening the size inspector and overriding the intrinsicContentSize to `placeholder` value.
    /// This is an override for design time. At runtime it will use the override in our ContentSizingTableView class
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
