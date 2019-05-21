//
//  UIButton.swift
//  GTDevTools
//
//  Created by Bernie Cartin on 5/21/19.
//  Copyright © 2019 Garson Tech. All rights reserved.
//

import UIKit



extension UIButton {
    
    public enum UIButtonStyle {
        case square
        case rounded
        case circular
    }
    
    open func loadImage(from urlString: String) {
        self.imageView?.clipsToBounds = true
        self.imageView?.contentMode = .scaleAspectFill
        self.imageView?.image = nil
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.setImage(cachedImage, for: .normal)
            return
        }
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if url.absoluteString != urlString {
                return
            }
            guard let imageData = data else {return}
            if let photoImage = UIImage(data: imageData) {
                imageCache.setObject(photoImage, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    self.setImage(photoImage, for: .normal)
                }
            }
            }.resume()
    }
    
    convenience public init(style: UIButtonStyle, title: String, titleColor: UIColor, font: UIFont = .systemFont(ofSize: 14), backgroundColor: UIColor = .clear, target: Any? = nil, action: Selector? = nil) {
        self.init(type: .system)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = backgroundColor
        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
        switch style {
        case .circular:
            layer.cornerRadius = 22
        case .rounded:
            layer.cornerRadius = 10
        case .square:
            layer.cornerRadius = 0
        }
        setSizeAnchors(height: 44, width: 150)
    }
    
    convenience public init(image: UIImage, tintColor: UIColor? = nil) {
        self.init(type: .system)
        if tintColor == nil {
            setImage(image, for: .normal)
        } else {
            setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            self.tintColor = tintColor
        }
        
    }
    
}
