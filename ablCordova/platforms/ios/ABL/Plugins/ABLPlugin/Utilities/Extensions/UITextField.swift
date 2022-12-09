//
//  UITextField.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 03/03/2022.
//

import UIKit

@IBDesignable extension UITextField {

    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }


//    @IBInspectable var bottomBorderColor: UIColor? {
//        get {
//            return self.bottomBorderColor
//        }
//        set {
//            self.borderStyle = .none
//            let border = CALayer()
//            let width = CGFloat(0.5)
//            border.borderColor = newValue?.cgColor
//            border.frame = CGRect(x: 0, y: 0,   width:  self.frame.size.width, height: self.frame.size.height)
//
//            border.borderWidth = width
//            self.layer.addSublayer(border)
//            self.layer.cornerRadius = 6
//            self.layer.masksToBounds = true
//        }
//    }

    @IBInspectable var paddingLeftCustom: CGFloat {
        
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }

    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    
//    @IBInspectable var fullBorderColor: UIColor? {
//        get {
//            return self.fullBorderColor
//        }
//        set {
//            borderStyle = .none
//            layer.borderColor = newValue?.cgColor
//            layer.borderWidth = 0.5
//        }
//     }
//
//     @IBInspectable var fullBorderWidth: CGFloat? {
//         get {
//             return self.fullBorderWidth
//         }
//         set {
//             layer.borderWidth = newValue
//         }
//     }
//
    @IBInspectable override var borderColor: UIColor? {
        get {
            return self.borderColor
        }
        set {
            layer.borderColor = newValue?.cgColor
            layer.borderWidth = 1
            layer.cornerRadius = 6
            layer.masksToBounds = true
        }
    }

    
    @IBInspectable override var cornerRadius: CGFloat  {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
