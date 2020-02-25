//
//  FNWebVC.swift
//  fnet
//
//  Created by mac on 9/3/19.
//  Copyright © 2019 Eddie. All rights reserved.
//

import UIKit
import WebKit

/// Just a simple webView
final class FNWebVC: BaseVC {

    /// main url of the webView
    var url: URL!

    private weak var webView: WKWebView!
    private weak var progressView: UIProgressView!

    convenience init(url: URL) {
        self.init()
        self.url = url
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: url))
    }

    override func loadView() {
        super.loadView()

        let progress = UIProgressView(progressViewStyle: .default)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progress = 0

        view.addSubview(progress)
        view.addConstraints([
            progress.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progress.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        let wv = WKWebView(frame: .zero)
        wv.translatesAutoresizingMaskIntoConstraints = false
        wv.navigationDelegate = self

        view.addSubview(wv)
        view.addConstraints([
            wv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wv.topAnchor.constraint(equalTo: progress.bottomAnchor),
            wv.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wv.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        progressView = progress
        webView = wv
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "estimatedProgress" else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }

        progressView.progress = Float(webView.estimatedProgress)
    }
}

extension FNWebVC: WKNavigationDelegate {

    func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
        // Make sure our animation is visible.
        if progressView.isHidden { progressView.isHidden = false }

        UIView.animate(withDuration: 0.33,
                       animations: {
                        self.progressView.alpha = 1.0
        })
    }

    func webView(_: WKWebView, didFinish _: WKNavigation!) {
        UIView.animate(withDuration: 0.33,
                       animations: { self.progressView.alpha = 0.0 },
                       completion: { isFinished in

            // Update `isHidden` flag accordingly:
            //  - set to `true` in case animation was completly finished.
            //  - set to `false` in case animation was interrupted, e.g. due to starting of another animation.
            self.progressView.isHidden = isFinished
        })
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("\(#function): \(error)")
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("\(#function): \(error)")
    }
}
