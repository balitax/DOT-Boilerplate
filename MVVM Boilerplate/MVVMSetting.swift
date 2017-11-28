//
//  MVVMSetting.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 27/11/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import Foundation
import UIKit


struct MVVMSetting {
    
    
    /// Init Root ViewController
    ///
    /// - Parameter window: UIWindow
    static func initRoot() -> UIWindow {
        var window = UIWindow()
        window = UIWindow(frame: UIScreen.main.bounds)
        let initialViewController = SplashView(nibName: "SplashView", bundle: nil)

        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        
        window.rootViewController = initialViewController
        window.makeKeyAndVisible()
        
        return window
        
    }
    
}
