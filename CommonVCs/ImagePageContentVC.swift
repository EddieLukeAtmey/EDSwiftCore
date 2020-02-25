//
//  ImagePageContentVC.swift
//  fnet
//
//  Created by Eddie on 5/15/19.
//  Copyright © 2019 Eddie. All rights reserved.
//

import UIKit
import Nuke

/// PageView's Image Only ContentView
final class ImagePageContentVC: UIViewController, PageContentVCProtocol {
    typealias M = UIImage
    var pageIndex: Int = 0
    var model: M! {
        didSet { imageView.image = model }
    }

    var imageView: UIImageView! { return view as? UIImageView }

    override func loadView() {
        let view = UIImageView(image: model)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        self.view = view
    }
}

final class ImageURLPageContentVC: UIViewController, PageContentVCProtocol {
    typealias M = NSURL
    var pageIndex: Int = 0
    var model: M!

    var imageView: UIImageView! { return view as? UIImageView }

    override func loadView() {
        let view = UIImageView(image: nil)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        Nuke.loadImage(with: model as URL, into: view)
        self.view = view
    }
}
