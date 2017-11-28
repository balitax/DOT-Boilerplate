//
//  SplashView.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 27/11/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import UIKit

class SplashView: UIViewController {
    
    @IBOutlet weak var progress: UIProgressView!
    
    var counter:Int = 0 {
        didSet {
            let fractionalProgress = Float(counter) / 100.0
            let animated = counter != 0
            progress.setProgress(fractionalProgress, animated: animated)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.counter = 0
        for _ in 0..<100 {
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                 self.counter += 1
            })
        }
        
        // goto home
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let home = UINavigationController(rootViewController: HomeViewController())
            self.present(home, animated: true, completion: nil)
        }
        
    }


}
