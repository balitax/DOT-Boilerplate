//
//  NSObject+Extensions.swift
//  MVVM Boilerplate
//
//  Created by Agus Cahyono on 07/12/17.
//  Copyright © 2017 Agus Cahyono. All rights reserved.
//

import Foundation

extension NSObject {
    class func brc_swizzleMethod(_ origSelector: Selector, withMethod newSelector: Selector) {
        let origMethod = class_getInstanceMethod(self, origSelector)
        let newMethod = class_getInstanceMethod(self, newSelector)
        if class_addMethod(self, origSelector, method_getImplementation(newMethod!), method_getTypeEncoding(newMethod!)) {
            class_replaceMethod(self, newSelector, method_getImplementation(origMethod!), method_getTypeEncoding(origMethod!))
        }
        else {
            method_exchangeImplementations(origMethod!, newMethod!)
        }
    }
}
