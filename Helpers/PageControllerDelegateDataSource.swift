//
//  PageControllerDelegateDataSource.swift
//  fnet
//
//  Created by Eddie on 5/13/19.
//  Copyright © 2019 Eddie. All rights reserved.
//
// Convenience setup for UIPageController, handle auto transition, setup data source, binding pageControl...
// This help remove boiler plate codes.
//
// USAGE:
// 1. Implement ContentVC: Model, pageIndex & additions if need)
// 2. in VC that needs pageController, init 1 object class `PageControllerDelegateDataSource` associatedType = contentVC created in 1
// 3. Handle callback delegate of the VC.

import UIKit

protocol PageContentVCProtocol where Self: UIViewController {
    associatedtype M: AnyObject
    var pageIndex: Int { get set }
    var model: M! { get set }

    static func initial() -> Self?
}
extension PageContentVCProtocol {
    static func initial() -> Self? { return nil }
}

@objc protocol PageControllerCallbackProtocol: class {
    @objc optional func pageControllerWillBeginTransition()
    @objc optional func pageControllerDidSelect(_ model: AnyObject)
}

class PageControllerDelegateDataSource<T: PageContentVCProtocol>: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    private var selectionCallback: ((T.M) -> Void)?
    private(set) var dataSource: [T.M]!
    private weak var callbackDelegate: PageControllerCallbackProtocol?
    private weak var vc: UIPageViewController?
    private weak var pageControl: UIPageControl?
    var shouldRestart = true

    /// Init the page controller dataSource & Delegate
    /// - parameter pageVC: The pageVC to set the ds delegate
    /// - parameter dataSource: The data source (with model) for the delegate datasource
    /// - parameter pageControl: the UIPageControl attachted to this pageVC
    init(pageVC: UIPageViewController, dataSource: [T.M], callbackDelegate: PageControllerCallbackProtocol? = nil, pageControl: UIPageControl? = nil, selectionCallback: ((T.M) -> Void)? = nil) {
        super.init()
        self.callbackDelegate = callbackDelegate
        self.selectionCallback = selectionCallback
        self.dataSource = dataSource
        self.pageControl = pageControl
        pageControl?.numberOfPages = dataSource.count
        pageControl?.isHidden = dataSource.count < 2
        vc = pageVC
        vc?.delegate = self
        vc?.dataSource = self
    }

    // MARK: - PageController DataSource Delegate Handler
    // back
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard dataSource.count > 1, let viewControl = viewController as? T else { return nil }

        var index = viewControl.pageIndex
        if index == 0, shouldRestart { index = dataSource.count }

        return contentVC(at: index - 1)
    }

    // next
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard dataSource.count > 1, let viewControl = viewController as? T else { return nil }

        var index = viewControl.pageIndex
        if index == dataSource.count - 1, shouldRestart { index = -1 }

        return contentVC(at: index + 1)
    }

    /// No models -> No value
    private func contentVC(at index: Int) -> T? {

        guard 0 <= index, index < dataSource.count else { return nil }

        let contentVC = T.initial() ?? T(nibName: T.className, bundle: nil)
        contentVC.pageIndex = index
        contentVC.model = dataSource[index]
        return contentVC
    }

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        callbackDelegate?.pageControllerWillBeginTransition?()
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard finished, completed else { return }
        guard let currentIndex = (pageViewController.viewControllers?.first as? T)?.pageIndex else { return }
        callbackSelection(currentIndex)
    }

    // MARK: - selections
    func nextPage() {
        guard currentVC.pageIndex < dataSource.count - 1 else {
            if shouldRestart { select(0, transition: .forward); callbackSelection(0) }
            return
        }
        let index = currentVC.pageIndex + 1
        select(index, transition: .forward)
        callbackSelection(index)
    }

    func prevPage() {
        guard currentVC.pageIndex > 0 else {
            if shouldRestart { select(dataSource.count - 1, transition: .reverse); callbackSelection(dataSource.count - 1) }
            return
        }

        let index = currentVC.pageIndex - 1
        select(index, transition: .reverse)
        callbackSelection(index)
    }

    private func callbackSelection(_ index: Int) {
        pageControl?.currentPage = index
        callbackDelegate?.pageControllerDidSelect?(dataSource[index])
        selectionCallback?(dataSource[index])
    }

    /// Call from outside -> no callback if using this method
    func select(_ model: T.M, animated: Bool = true) {

        guard let modelIndex = dataSource.firstIndex(where: { $0 === model }) else { return }
        select(modelIndex, animated: animated)
        pageControl?.currentPage = modelIndex
    }

    func select(_ index: Int, transition: UIPageViewController.NavigationDirection? = nil, animated: Bool = true) {
        guard let contentVC = contentVC(at: index) else { return }

        var pageDirection = transition ?? .forward
        if animated, transition == nil, let pageIndex = (vc?.viewControllers?.first as? T)?.pageIndex { // auto direction (compare to previous index)
            pageDirection = contentVC.pageIndex > pageIndex ? .forward : .reverse
        }

        vc?.setViewControllers([contentVC], direction: pageDirection, animated: animated, completion: nil)
        pageControl?.currentPage = index
    }

    var currentVC: T { return vc?.viewControllers?.first as! T }

    func startTimer() {
        guard dataSource.count > 1 else { pageControl?.isHidden = true; return }
        pageControl?.isHidden = false
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self](_) in
            self?.nextPage()
            self?.startTimer()
        }
    }
}
