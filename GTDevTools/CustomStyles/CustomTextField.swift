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
        self.backgroundColor = .white
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    public init(placeholder: String, backgroundColor: UIColor = .white, borderColor: UIColor? = nil, keyboardType: UIKeyboardType = .default, isSecureText: Bool = false, cornerRadius: CGFloat = 0) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setSizeAnchors(height: 44, width: nil)
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecureText
        self.layer.cornerRadius = cornerRadius
        self.font = UIFont.systemFont(ofSize: 14)
        if borderColor != nil {
            self.layer.borderColor = borderColor?.cgColor
            layer.borderWidth = 0.5
        }
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
