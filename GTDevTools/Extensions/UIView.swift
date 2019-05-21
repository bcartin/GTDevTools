//
//  UIViewExtension.swift
//  GTDevTools
//
//  Created by Bernie Cartin on 5/21/19.
//  Copyright © 2019 Garson Tech. All rights reserved.
//

import UIKit

extension UIView {
    
    open func findFirstresponder() -> UIView? {
        if self.isFirstResponder {
            return self
        }
        else {
            for view in self.subviews {
                let firstResponder = view.findFirstresponder()
                if firstResponder != nil {
                    return firstResponder
                }
            }
        }
        return nil
    }
    
    open func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat ) {
        
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -paddingRight).isActive = true
        }
    }
    
    open func anchorTop(anchor: NSLayoutYAxisAnchor, paddingTop: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: anchor, constant: paddingTop).isActive = true
    }
    
    open func setSizeAnchors(height: CGFloat?, width: CGFloat?) {
        translatesAutoresizingMaskIntoConstraints = false
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    open func centerHorizontaly(offset: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            self.centerXAnchor.constraint(equalTo: superviewCenterXAnchor, constant: offset).isActive = true
        }
        
    }
    
    open func centerVertically(offset: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            self.centerYAnchor.constraint(equalTo: superviewCenterYAnchor, constant: offset).isActive = true
        }
    }
    
    open func fadeTo(alphaValue: CGFloat, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = alphaValue
        }
    }
    
    open func setupShadow(opacity: Float = 0, radius: CGFloat = 0, offset: CGSize = .zero, color: UIColor = .black) {
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
    }
    
    open func fillSuperviewSafeAreaLayoutGuide() {
        if #available(iOS 11.0, *) {
            guard let superviewTopAnchor = superview?.safeAreaLayoutGuide.topAnchor,
                let superviewBottomAnchor = superview?.safeAreaLayoutGuide.bottomAnchor,
                let superviewLeftAnchor = superview?.safeAreaLayoutGuide.leadingAnchor,
                let superviewRightAnchor = superview?.safeAreaLayoutGuide.trailingAnchor else { return }
            anchor(top: superviewTopAnchor, leading: superviewLeftAnchor, bottom: superviewBottomAnchor, trailing: superviewRightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
            }
    }
    
    open func fillSuperview() {
        if #available(iOS 11.0, *) {
            guard let superviewTopAnchor = superview?.topAnchor,
                let superviewBottomAnchor = superview?.bottomAnchor,
                let superviewLeftAnchor = superview?.leadingAnchor,
                let superviewRightAnchor = superview?.trailingAnchor else { return }
            anchor(top: superviewTopAnchor, leading: superviewLeftAnchor, bottom: superviewBottomAnchor, trailing: superviewRightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        }
    }
    
    @discardableResult
    func withBorder(width: CGFloat, color: UIColor) -> UIView {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        return self
    }
}
