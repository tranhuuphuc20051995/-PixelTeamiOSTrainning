//
//  BaseNav.swift
//  Trainning
//
//  Created by Tri on 2020/10/08.
//

import UIKit

class BaseNav: UINavigationController {

    override var childForStatusBarStyle: UIViewController? {
        return self.visibleViewController
    }

}
