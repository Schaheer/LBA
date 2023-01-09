//
//  RoundedImageView.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 15/03/2022.
//

import UIKit

@IBDesignable
class CustomImageView: UIImageView {
    @IBInspectable override var borderWidth: CGFloat {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable override var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable override var cornerRadius: CGFloat  {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}
