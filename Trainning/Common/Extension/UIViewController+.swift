//
//  UIViewController+.swift
//  altar
//
//  Created by TuanLVT on 7/21/20.
//

import RxCocoa
import RxSwift

extension UIStoryboard {
    
    func instantiateVC<T: UIViewController>(ofType _: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        return instantiateViewController(withIdentifier: identifier) as! T
    }
}
extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideNav() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func showNav() {
        navigationController?.navigationBar.isHidden = false
    }
}

extension UIViewController {

    func presentVC(with viewController: UIViewController,
                 modalStyle: UIModalPresentationStyle = .overFullScreen,
                 isTransitioningDelegate: Bool = true,
                 aniamted: Bool = true,
                 completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = modalStyle
        if (isTransitioningDelegate) {
            viewController.transitioningDelegate = ModalAnimationTransitions.shared
        }
        present(viewController, animated: aniamted, completion: completion)
    }
    
    func dismissVC(animated: Bool = true, completion: (() -> Void)? = nil) {
        self.dismiss(animated: animated, completion: completion)
    }
    
    func pushVC(with viewController: UIViewController, aniamted: Bool = true ) {
        navigationController?.delegate = NavigationControllerDelegate.shared
        navigationController?.pushViewController(viewController, animated: aniamted)
    }
    
    func popVC(aniamted: Bool = true) {
        navigationController?.popViewController(animated: aniamted)
    }

    func pop(numberOfTimes: Int) {
        guard let navigationController = navigationController else {
            return
        }
        let viewControllers = navigationController.viewControllers
        let index = numberOfTimes + 1
        if viewControllers.count >= index {
            navigationController.popToViewController(viewControllers[viewControllers.count - index], animated: true)
        }
    }
    
    func pusHideTabbar(with viewController: UIViewController, aniamted: Bool = true) {
        tabBarController?.setTabBarHidden(true, animated: aniamted)
        pushVC(with: viewController, aniamted: aniamted)
    }
    
    func popShowTabbar(aniamted: Bool = true) {
        popVC(aniamted: true)
        tabBarController?.setTabBarHidden(false, animated: aniamted)
    }
    
}

extension UITabBarController {
    func setTabBarHidden(_ isHidden: Bool, animated: Bool, completion: (() -> Void)? = nil ) {
        if (tabBar.isHidden == isHidden) {
            completion?()
        }

        if !isHidden {
            tabBar.isHidden = false
        }

        let height = tabBar.frame.size.height
        let offsetY = view.frame.height - (isHidden ? 0 : height)
        let duration = (animated ? 0.3 : 0.0)

        let frame = CGRect(origin: CGPoint(x: tabBar.frame.minX, y: offsetY), size: tabBar.frame.size)
        UIView.animate(withDuration: duration, animations: {
            self.tabBar.frame = frame
        }) { _ in
            self.tabBar.isHidden = isHidden
            completion?()
        }
    }
}
