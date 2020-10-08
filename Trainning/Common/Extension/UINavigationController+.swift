//
//  UINavigationController+.swift
//  altar
//
//  Created by Tri on 2020/08/10.
//

import UIKit

extension UINavigationController {
    
    func isExistVC(of aClass: AnyClass) -> Bool {
        for vc in self.viewControllers where vc.isKind(of: aClass) {
            return true
        }
        return false
    }
    
    func setRootViewController(_ viewController: UIViewController, animated: Bool = true) {
        self.setViewControllers([viewController], animated: animated)
    }
}
