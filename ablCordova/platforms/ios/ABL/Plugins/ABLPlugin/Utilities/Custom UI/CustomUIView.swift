//
//  BorderedView.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 14/03/2022.
//

import UIKit

@IBDesignable
class CustomUIView: UIView {
    @IBInspectable override var borderWidth: CGFloat  {
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
        }
    }
    
    @IBInspectable var hasBottomBorder: Bool = false {
        didSet {
            let thickness: CGFloat = 0.5
            let bottomBorder = CALayer()
            bottomBorder.backgroundColor = PluginColorAsset.textfieldLineBlack.color.cgColor
            bottomBorder.frame = CGRect(x: 0, y: frame.size.height - thickness, width: frame.size.width, height: thickness)
            layer.addSublayer(bottomBorder)
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}
