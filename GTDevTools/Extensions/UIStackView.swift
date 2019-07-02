//
//  UIStackView.swift
//  GTDevTools
//
//  Created by Bernie Cartin on 5/22/19.
//  Copyright © 2019 Garson Tech. All rights reserved.
//

import UIKit

extension UIStackView {
    
    @discardableResult
    open func withMargins(_ margins: UIEdgeInsets) -> UIStackView {
        layoutMargins = margins
        isLayoutMarginsRelativeArrangement = true
        return self
    }
    
    @discardableResult
    open func padLeft(_ left: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.left = left
        return self
    }
    
    @discardableResult
    open func padTop(_ top: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.top = top
        return self
    }
    
    @discardableResult
    open func padBottom(_ bottom: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.bottom = bottom
        return self
    }
    
    @discardableResult
    open func padRight(_ right: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.right = right
        return self
    }
    
    @discardableResult
    open func withAxis(_ axis: NSLayoutConstraint.Axis) -> UIView {
        self.axis = axis
        return self
    }
    
    @discardableResult
    open func withSpacing(_ spacing: CGFloat) -> UIView {
        self.spacing = spacing
        return self
    }
}
