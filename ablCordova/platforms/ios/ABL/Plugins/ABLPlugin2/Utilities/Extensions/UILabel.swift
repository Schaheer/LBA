//
//  UILabel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 03/03/2022.
//

import UIKit

extension UILabel {
    func makeAttributedText(stringToColor: String) {
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        attributedString.setColorForText(textForAttribute: stringToColor, withColor: PluginColorAsset.appOrange.color)
        self.attributedText = attributedString
    }
    
    func makeOTPAttributedText(boldString: String, underlinedString: String) {
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        attributedString.setBoldForText(textForAttribute: boldString)
        attributedString.setUnderlineForText(textForAttribute: underlinedString)
        self.attributedText = attributedString
    }
    
    func makeUnderlinedAttributedText(underlinedString: String) {
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        attributedString.setUnderlineForText(textForAttribute: underlinedString)
        self.attributedText = attributedString
    }
}
