//
//  DOTBaseViewController.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 27/11/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import UIKit

class DOTBaseViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    /// PREVIOUS ICON
    func previousIcon() {
        let btn1 = UIButton(type: .custom)
        btn1.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(self.popviewController), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.leftBarButtonItem = item1
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    
    /// GESTURE FOR PUSH NAVIGATION PREVIOUS
    ///
    /// - Parameters:
    ///   - gestureRecognizer: Gesture description
    ///   - otherGestureRecognizer: other desture
    /// - Returns: Boolean gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    /// Action for gesture of previous page
    @objc func popviewController() {
        self.navigationController?.popViewController(animated: true)
    }

    
    /// SHOW ALERT MESSAGE
    ///
    /// - Parameter message: message
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "".displayName, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /// ADD SYSTEM BUTTON IN NAVBAR
    ///
    /// - Parameters:
    ///   - sender: sender
    ///   - type: type of button system
    func addSystemButtonNavbar(sender: Selector, type: UIBarButtonSystemItem) {
        let button = UIBarButtonItem(barButtonSystemItem: type, target: self, action: sender)
        navigationItem.rightBarButtonItem = button
    }
    
    
    /// PUSHING VIEWCONTROLLER
    ///
    /// - Parameter viewController: viewcontroller as page
    func pushNavigation(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    /// PRESENT UIVIEWCONTROLLER
    ///
    /// - Parameter viewController: viewcontroller as page
    func presentNavigation( _ viewController: UIViewController) {
        let embedNavigation = UINavigationController(rootViewController: viewController)
        self.present(embedNavigation, animated: true, completion: nil)
    }
    
    

}

extension String {
    var displayName: String? {
        return Bundle.main.infoDictionary!["CFBundleName"] as? String
    }
}
