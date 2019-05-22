//
//  CustomTextField.swift
//  GTDevTools
//
//  Created by Bernie Cartin on 5/21/19.
//  Copyright © 2019 Garson Tech. All rights reserved.
//

import UIKit

open class CustomTextField: UITextField {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fieldInit(backgroundColor: .white)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        fieldInit(backgroundColor: .white)
    }
    
    public init(placeholder: String, backgroundColor: UIColor = .white) {
        super.init(frame: .zero)
        fieldInit(backgroundColor: backgroundColor)
        self.placeholder = placeholder
    }
    
    func fieldInit(backgroundColor: UIColor) {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 5
        font = UIFont.systemFont(ofSize: 14)
        self.backgroundColor = backgroundColor
        self.setSizeAnchors(height: 44, width: nil)
    }
    
    
    
    let padding = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
