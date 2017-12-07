//
//  DOTBaseViewController.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 27/11/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import UIKit

class DOTBaseViewController: UIViewController, UIGestureRecognizerDelegate {

    var picker = UIImagePickerController()
    
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
    func addSystemButtonNavbarOnRight(sender: Selector, type: UIBarButtonSystemItem) {
        let button = UIBarButtonItem(barButtonSystemItem: type, target: self, action: sender)
        navigationItem.rightBarButtonItem = button
    }
    
    /// ADD SYSTEM BUTTON IN NAVBAR
    ///
    /// - Parameters:
    ///   - sender: sender
    ///   - type: type of button system
    func addSystemButtonNavbarOnLeft(sender: Selector, type: UIBarButtonSystemItem) {
        let button = UIBarButtonItem(barButtonSystemItem: type, target: self, action: sender)
        navigationItem.leftBarButtonItem = button
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
    
    
    /// CHOOSE IMAGE FUNCTION
    ///
    /// - Parameter delegate: delegate image picker and navigation controller
    func didChooseImage(_ delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)) {
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(
            title: "Camera", style: UIAlertActionStyle.default){ UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(
            title: "Gallery",
            style: UIAlertActionStyle.default){ UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: UIAlertActionStyle.cancel) {UIAlertAction in
                
        }
        
        // Add the actions
        picker.delegate = delegate
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    /// OPEN CAMERA FOR CHOOSE IMAGE
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(
            UIImagePickerControllerSourceType.camera)) {
            picker.sourceType = UIImagePickerControllerSourceType.camera
            self .present(picker, animated: true, completion: nil)
        } else {
            self.showAlert("You haven't a camera!")
        }
    }
    
    
    
    /// OPEN GALLERY FOR CHOOSE IMAGE
    func openGallary()  {
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
}

extension String {
    var displayName: String? {
        return Bundle.main.infoDictionary!["CFBundleName"] as? String
    }
}
