//
//  ModalAnimationTransitions.swift
//  altar
//
//  Created by Tri on 2020/09/25.
//

import UIKit

class ModalAnimationTransitions: NSObject, UIViewControllerTransitioningDelegate {
    static let shared = ModalAnimationTransitions()
    
    private override init() {}
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalAnimator(isPresenting: true, forNavigation: false)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalAnimator(isPresenting: false, forNavigation: false)
    }
}
