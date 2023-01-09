//
//  NSMutableAttributedString.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 03/03/2022.
//

import UIKit

extension NSMutableAttributedString {

    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)

        // Swift 4.2 and above
        self.addAttribute(.foregroundColor, value: color, range: range)
    }
    
    func setBoldForText(textForAttribute: String) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)

        // Swift 4.2 and above
        self.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 14), range: range)
    }
    
    func setUnderlineForText(textForAttribute: String) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)

        // Swift 4.2 and above
        self.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
    }
}
