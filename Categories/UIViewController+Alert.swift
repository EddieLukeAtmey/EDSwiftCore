//
//  UIViewController_Alert.swift
//  EDSwiftCore
//
//  Created by Eddie Luke Atmey on 08/28/18.
//

import UIKit

public extension UIViewController {

    /**
     *  Show alert with Ok action.
     *
     *  @param  title   title of alert.
     *  @param  message message of alert.
     *  @returns created alert controller for further modification
     */
    func es_showOkAlert(title: String?, msg: String?) -> UIAlertController {
        return es_showOkAlert(title: title, msg: msg, okAction:nil)
    }

    /**
     *  Show alert with Ok action.
     *
     *  @param  title   title of alert.
     *  @param  message message of alert.
     *  @param  okAction    okAction.
     *  @returns created alert controller for further modification
     */
    func es_showOkAlert(title: String?, msg: String?, okAction: (() -> Void)? ) -> UIAlertController {

        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in okAction?() })

        present(alert, animated: true, completion: nil)
        return alert
    }

    /**
     *  Show alert with Ok / cancel action.
     *
     *  @param  title   title of alert.
     *  @param  msg message of alert.
     *  @param  okTitle title of OK button.
     *  @param  cancelTitle title of cancel button.
     *  @param  action: handle action with bool param (true = ok, false = cancel).
     *  @returns created alert controller for further modification
     */
    func es_showConfirmAlert(title: String?,
                             msg: String?,
                             okTitle: String = "OK",
                             cancelTitle: String = "Cancel",
                             action: ((_: Bool) -> Void)? ) -> UIAlertController {

        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: okTitle, style: .default)    { _ in action?(true) })
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel) { _ in action?(false) })

        present(alert, animated: true, completion: nil)
        return alert
    }
}
