//
//  CustomUITextField.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 18/04/2022.
//

import UIKit

//@IBDesignable
//class CustomUITextField: UITextField {
    
//    @IBInspectable var placeHolderColor: UIColor = .gray {
//        didSet {
//            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: placeHolderColor])
//        }
//    }
//
//    var textPadding = UIEdgeInsets(
//        top: 0,
//        left: 20,
//        bottom: 0,
//        right: 20
//    )
//
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        let rect = super.textRect(forBounds: bounds)
//        return rect.inset(by: textPadding)
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        let rect = super.editingRect(forBounds: bounds)
//        return rect.inset(by: textPadding)
//    }
//
//
//    @IBInspectable var borderColor: UIColor? = UIColor.clear {
//        didSet {
//            layer.borderColor = self.borderColor?.cgColor
//        }
//    }
//
//    @IBInspectable var borderWidth: CGFloat = 0 {
//        didSet {
//            layer.borderWidth = self.borderWidth
//        }
//    }
//
//    @IBInspectable var cornerRadius: CGFloat = 0 {
//        didSet {
//            layer.cornerRadius = self.cornerRadius
//        }
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    override func draw(_ rect: CGRect) {
//        self.layer.cornerRadius = self.cornerRadius
//        self.layer.borderWidth = self.borderWidth
//        self.layer.borderColor = self.borderColor?.cgColor
//        self.layer.masksToBounds = self.cornerRadius > 0
//    }
//}
