//
//  Tools.swift
//  GTDevTools
//
//  Created by Bernie Cartin on 5/24/19.
//  Copyright © 2019 Garson Tech. All rights reserved.
//

import UIKit

open class Tools {
    
    public init() {}
    public static let shared = Tools()
    
    public func resizeImage(image: UIImage) -> UIImage {
        var returnImage : UIImage = UIImage()
        var actualHeight = image.size.height
        var actualWidth = image.size.width
        let maxWidth : CGFloat = 400.0
        let maxHeight : CGFloat = 700.0
        var imageRatio = actualWidth/actualHeight
        let maxRatio = maxWidth/maxHeight
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imageRatio < maxRatio {
                imageRatio = maxHeight / actualHeight
                actualWidth = imageRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imageRatio > maxRatio{
                imageRatio = maxWidth / actualWidth
                actualHeight = imageRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        if let img = UIGraphicsGetImageFromCurrentImageContext() {
            if let imageData = img.jpegData(compressionQuality: 1.0) {
                UIGraphicsEndImageContext()
                returnImage = UIImage(data: imageData)!
            }
        }
        return returnImage
    }
}
