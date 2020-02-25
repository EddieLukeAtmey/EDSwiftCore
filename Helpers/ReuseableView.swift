//
//  ReuseableView.swift
//  fnet
//
//  Created by Eddie on 5/28/19.
//  Copyright © 2019 Eddie. All rights reserved.
//

import UIKit

/// Ref: https://stackoverflow.com/a/37668821/1696598
class ReuseableView: UIView {
    private lazy var contentView = loadViewFromNib()

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        contentView = loadViewFromNib()

        // use bounds not frame or it'll be offset
        contentView.frame = bounds

        // Make the view stretch with containing view
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView)
    }

    func loadViewFromNib() -> UIView {

        let bundle = Bundle(for: type(of: self))
        return UINib(nibName: className, bundle: bundle).instantiate(withOwner: self, options: nil).first as! UIView
    }
}
