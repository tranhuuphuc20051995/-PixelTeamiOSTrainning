//
//  ModalAnimator.swift
//  altar
//
//  Created by Tri on 2020/09/25.
//

import UIKit

protocol ModalAnimatable {
    var disableModalAnimation: Bool { get }
}

extension ModalAnimatable {
    var disableModalAnimation: Bool {
        get { false }
    }
}

final class ModalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let isPresenting: Bool
    let forNavigation: Bool
    let scaleTransform = CGAffineTransform(scaleX: 0.9, y: 0.9)

    init(isPresenting: Bool, forNavigation: Bool) {
        self.isPresenting = isPresenting
        self.forNavigation = forNavigation
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            if forNavigation {
                animateForNavigationPush(context: transitionContext)
            } else {
                animateForPresentation(context: transitionContext)
            }
        } else {
            if forNavigation {
                animateForNavigationPop(context: transitionContext)
            } else {
                animateForDismissal(context: transitionContext)
            }
        }
    }
    
    func animateForPresentation(context: UIViewControllerContextTransitioning) {
        guard let to = context.viewController(forKey: .to) else { return }

        let containerView = context.containerView
        containerView.addSubview(to.view)
        
        to.view.transform = scaleTransform
        to.view.alpha = 0.0
        UIView.animate(withDuration: transitionDuration(using: context), animations: {
            to.view.transform = .identity
            to.view.alpha = 1.0
        }) { (completed) in
            context.completeTransition(true)
        }
    }

    func animateForDismissal(context: UIViewControllerContextTransitioning) {
        guard let from = context.viewController(forKey: .from) else { return }
        
        from.view.transform = .identity
        from.view.alpha = 1.0
        UIView.animate(withDuration: transitionDuration(using: context), animations: { [weak self] in
            guard let self = self else { return }
            from.view.transform = self.scaleTransform
            from.view.alpha = 0.0
        }) { (completed) in
            context.completeTransition(true)
        }
    }
    
    func animateForNavigationPush(context: UIViewControllerContextTransitioning) {
        guard let from = context.viewController(forKey: .from) else { return }
        guard let to = context.viewController(forKey: .to) else { return }

        let containerView = context.containerView
        
        to.view.transform = scaleTransform
        to.view.alpha = 0.0
        containerView.insertSubview(to.view, aboveSubview: from.view)
        UIView.animate(withDuration: transitionDuration(using: context), animations: {
            to.view.transform = .identity
            to.view.alpha = 1.0
        }) { (completed) in
            context.completeTransition(true)
        }
    }
    
    func animateForNavigationPop(context: UIViewControllerContextTransitioning) {
        guard let from = context.viewController(forKey: .from) else { return }
        guard let to = context.viewController(forKey: .to) else { return }
        
        let containerView = context.containerView
        
        from.view.transform = .identity
        from.view.alpha = 1.0
        containerView.insertSubview(to.view, belowSubview: from.view)
        UIView.animate(withDuration: transitionDuration(using: context), animations: { [weak self] in
            guard let self = self else { return }
            from.view.transform = self.scaleTransform
            from.view.alpha = 0.0
        }) { (completed) in
            context.completeTransition(true)
        }
    }
}
