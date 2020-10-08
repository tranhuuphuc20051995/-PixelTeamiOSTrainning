//
//  ModalAnimationTransitions.swift
//  altar
//
//  Created by Tri on 2020/09/25.
//

import UIKit

class NavigationControllerDelegate: NSObject {
    static let shared = NavigationControllerDelegate()
}

extension NavigationControllerDelegate: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        let criteriaVC = operation == .push ? toVC : fromVC
        switch criteriaVC {
        case let modalVC as ModalAnimatable:
            if modalVC.disableModalAnimation {
                // ModalAnimable指定してても無効状態なら通常のアニメーションにする
                return nil
            } else {
                return ModalAnimator(isPresenting: operation == .push, forNavigation: true)
            }
        default:
            return nil
        }
    }
}
