//
//  UIView+.swift
//  altar
//
//  Created by Tri on 2020/07/29.
//

import UIKit

extension UIView {
    /**
     Fade in a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeIn(duration: TimeInterval = 0.5, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        }, completion: { _ in
            completion?()
        })
    }
    
    /**
     Fade out a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeOut(_ duration: TimeInterval = 0.5, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        }, completion: { _ in
            completion?()
        })
    }
    
    // MARK: - Layout
    func bindFrame(to view: UIView) {
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
  
    class func loadXibView<T: UIView>(fromNib viewType: T.Type, owner: Any?) -> UIView {
        let nibName = String(describing: viewType)
        let nib = UINib.init(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: owner, options: nil)[0] as! UIView
    }
    
    
    func incenesActionAnimation(completion: (() -> Void)? = nil) {
        let oldCenterPosition = center.y
        UIView.animate(withDuration: 1, delay: 0.1, options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat],
                       animations: {
                        UIView.setAnimationRepeatCount(3)
                        self.center.y -= self.bounds.height / 2
                       }, completion: { (value: Bool) in
                        self.center.y = oldCenterPosition
                        completion?()
                       })
    }
    
    func roundCorners(with CACornerMask: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [CACornerMask]
    }
}

@IBDesignable
extension UIView {
    
    @IBInspectable
    var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
