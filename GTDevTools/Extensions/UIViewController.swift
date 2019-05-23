//
//  UIViewController.swift
//  GTDevTools
//
//  Created by Bernie Cartin on 5/21/19.
//  Copyright © 2019 Garson Tech. All rights reserved.
//

import UIKit

var screenOrigin: CGFloat = 0

extension UIViewController: UITextFieldDelegate, UITextViewDelegate {
    
    open func shouldPresentLoadingView(_ status: Bool) {
        var fadeView: UIView?
        
        if status == true {
            fadeView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            fadeView?.backgroundColor = UIColor.black
            fadeView?.alpha = 0.0
            fadeView?.tag = 98
            let spinner = UIActivityIndicatorView()
            spinner.color = UIColor.white
            spinner.style = .whiteLarge
            spinner.center = view.center
            view.addSubview(fadeView!)
            fadeView?.addSubview(spinner)
            spinner.startAnimating()
            fadeView?.fadeTo(alphaValue: 0.8, withDuration: 0.2)
        }
        else {
            for subView in view.subviews {
                if subView.tag == 98 {
                    UIView.animate(withDuration: 0.2, animations: {
                        subView.alpha = 0.0
                    }, completion: { (finished) in
                        subView.removeFromSuperview()
                    })
                }
            }
        }
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc
    open func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    open func setupViewResizerOnKeyboardShown() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(UIViewController.keyboardWillShowForResizing),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(UIViewController.keyboardWillHideForResizing),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc
    open func keyboardWillShowForResizing(notification: Notification) {
        
        guard let firstResponder = self.view.findFirstresponder() else {return}
        screenOrigin = self.view.frame.origin.y
        let origin = self.view.safeAreaLayoutGuide.layoutFrame.origin.y
        let objectY = firstResponder.frame.origin.y
        let objectHeight = firstResponder.frame.height
        let screenHeight = self.view.safeAreaLayoutGuide.layoutFrame.height
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        let keyboardHeight = keyboardSize.height
        
        let moveSize = (keyboardHeight - (screenHeight - objectY)) + objectHeight
        
        if screenHeight - (objectY + objectHeight) < keyboardHeight {
            if origin == 0 {
                self.view.frame.origin.y -= (moveSize + 10) //keyboardSize.height
            }
        }
    }
    
    @objc
    open func keyboardWillHideForResizing(notification: Notification) {
        
        guard let firstResponder = self.view.findFirstresponder() else {return}
        let origin = self.view.frame.origin.y
        let objectY = firstResponder.frame.origin.y
        let objectHeight = firstResponder.frame.height
        let screenHeight = self.view.safeAreaLayoutGuide.layoutFrame.height
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        let keyboardHeight = keyboardSize.height
        
        let moveSize = (keyboardHeight - (screenHeight - objectY)) + objectHeight
        
        if origin != screenOrigin {
            self.view.frame.origin.y += (moveSize + 10) //keyboardSize.height
        }
    }
    
}

public protocol Alertable {}

extension Alertable where Self: UIViewController {
    
    public func showAlert(title: String, msg: String?) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    public func showMessage(message: String, center: CGPoint?) {
        DispatchQueue.main.async {
            let savedLabel = UILabel()
            savedLabel.text = message
            savedLabel.textColor = .white
            savedLabel.numberOfLines = 0
            savedLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
            savedLabel.font = UIFont.boldSystemFont(ofSize: 18)
            savedLabel.textAlignment = .center
            savedLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 80)
            if let center = center {
                savedLabel.center = center
            }
            else {
                savedLabel.center = self.view.center
            }
            self.view.addSubview(savedLabel)
            savedLabel.layer.transform = CATransform3DMakeScale(0, 0, 0)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                savedLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
            }, completion: { (completed) in
                //COMPLETED ANIMATION
                UIView.animate(withDuration: 0.5, delay: 0.75, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    savedLabel.layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01)
                    savedLabel.alpha = 0
                }, completion: { (_) in
                    savedLabel.removeFromSuperview()
                })
            })
        }
    }
}
